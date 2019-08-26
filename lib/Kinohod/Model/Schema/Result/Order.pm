use utf8;
package Kinohod::Model::Schema::Result::Order;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Kinohod::Model::Schema::Result::Order

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

=head1 TABLE: C<orders>

=cut

__PACKAGE__->table("orders");

=head1 ACCESSORS

=head2 uuid

  data_type: 'uuid'
  default_value: uuid_generate_v4()
  is_nullable: 0
  size: 16

=head2 status

  data_type: 'integer'
  is_nullable: 0

=head2 event_uuid

  data_type: 'uuid'
  is_foreign_key: 1
  is_nullable: 0
  size: 16

=head2 ticket_count

  data_type: 'integer'
  is_nullable: 0

=head2 ticket_price

  data_type: 'numeric'
  is_nullable: 0

=head2 order_cost

  data_type: 'numeric'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "uuid",
  {
    data_type => "uuid",
    default_value => \"uuid_generate_v4()",
    is_nullable => 0,
    size => 16,
  },
  "status",
  { data_type => "integer", is_nullable => 0 },
  "event_uuid",
  { data_type => "uuid", is_foreign_key => 1, is_nullable => 0, size => 16 },
  "ticket_count",
  { data_type => "integer", is_nullable => 0 },
  "ticket_price",
  { data_type => "numeric", is_nullable => 0 },
  "order_cost",
  { data_type => "numeric", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</uuid>

=back

=cut

__PACKAGE__->set_primary_key("uuid");

=head1 RELATIONS

=head2 event_uuid

Type: belongs_to

Related object: L<Kinohod::Model::Schema::Result::Event>

=cut

__PACKAGE__->belongs_to(
  "event_uuid",
  "Kinohod::Model::Schema::Result::Event",
  { uuid => "event_uuid" },
  { is_deferrable => 0, on_delete => "RESTRICT", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-08-17 14:01:08
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:yvm0GxeKShjF9S4Tw5/lvQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
