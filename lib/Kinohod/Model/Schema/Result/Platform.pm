use utf8;
package Kinohod::Model::Schema::Result::Platform;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Kinohod::Model::Schema::Result::Platform

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

=head1 TABLE: C<platforms>

=cut

__PACKAGE__->table("platforms");

=head1 ACCESSORS

=head2 uuid

  data_type: 'uuid'
  default_value: uuid_generate_v4()
  is_nullable: 0
  size: 16

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 type

  data_type: 'integer'
  is_nullable: 0

=head2 is_active

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "uuid",
  {
    data_type => "uuid",
    default_value => \"uuid_generate_v4()",
    is_nullable => 0,
    size => 16,
    readonly => 1,
  },
  "name",
  { data_type => "text", is_nullable => 0 },
  "type",
  { data_type => "integer", is_nullable => 0 },
  "is_active",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</uuid>

=back

=cut

__PACKAGE__->set_primary_key("uuid");

=head1 UNIQUE CONSTRAINTS

=head2 C<platforms_name_key>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("platforms_name_key", ["name"]);

=head1 RELATIONS

=head2 events

Type: has_many

Related object: L<Kinohod::Model::Schema::Result::Event>

=cut

__PACKAGE__->has_many(
  "events",
  "Kinohod::Model::Schema::Result::Event",
  { "foreign.platform_uuid" => "self.uuid" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-08-17 14:01:08
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:F9/xkXVg6F3oSARMPr8wgw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
