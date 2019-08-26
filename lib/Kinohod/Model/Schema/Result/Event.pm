use utf8;
package Kinohod::Model::Schema::Result::Event;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Kinohod::Model::Schema::Result::Event

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<events>

=cut

__PACKAGE__->table("events");

=head1 ACCESSORS

=head2 uuid

  data_type: 'uuid'
  default_value: uuid_generate_v4()
  is_nullable: 0
  size: 16

=head2 platform_uuid

  data_type: 'uuid'
  is_foreign_key: 1
  is_nullable: 0
  size: 16

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 ts_created

  data_type: 'timestamp'
  default_value: (now())::timestamp without time zone
  is_nullable: 0

=head2 ts_start

  data_type: 'timestamp'
  is_nullable: 0

=head2 duration

  data_type: 'integer'
  is_nullable: 0

=head2 ticket_price

  data_type: 'numeric'
  is_nullable: 0

=head2 is_active

  data_type: 'boolean'
  default_value: false
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "uuid",
  {
    data_type => "uuid",
    default_value => \"uuid_generate_v4()",
    is_nullable => 0,
    size => 16,
  },
  "platform_uuid",
  { data_type => "uuid", is_foreign_key => 1, is_nullable => 0, size => 16 },
  "name",
  { data_type => "text", is_nullable => 0 },
  "ts_created",
  {
    data_type     => "timestamp",
    default_value => \"(now())::timestamp without time zone",
    is_nullable   => 0,
  },
  "ts_start",
  { data_type => "timestamp", is_nullable => 0 },
  "duration",
  { data_type => "integer", is_nullable => 0 },
  "ticket_price",
  { data_type => "numeric", is_nullable => 0 },
  "is_active",
  { data_type => "boolean", default_value => \"false", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</uuid>

=back

=cut

__PACKAGE__->set_primary_key("uuid");

=head1 RELATIONS

=head2 orders

Type: has_many

Related object: L<Kinohod::Model::Schema::Result::Order>

=cut

__PACKAGE__->has_many(
  "orders",
  "Kinohod::Model::Schema::Result::Order",
  { "foreign.event_uuid" => "self.uuid" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 platform_uuid

Type: belongs_to

Related object: L<Kinohod::Model::Schema::Result::Platform>

=cut

__PACKAGE__->belongs_to(
  "platform_uuid",
  "Kinohod::Model::Schema::Result::Platform",
  { uuid => "platform_uuid" },
  { is_deferrable => 0, on_delete => "RESTRICT", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-08-17 14:01:08
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:g2YnRfNRGvVJSRGC22Oz2A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
