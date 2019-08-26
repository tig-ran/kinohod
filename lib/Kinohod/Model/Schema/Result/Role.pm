use utf8;
package Kinohod::Model::Schema::Result::Role;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Kinohod::Model::Schema::Result::Role

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

=head1 TABLE: C<roles>

=cut

__PACKAGE__->table("roles");

=head1 ACCESSORS

=head2 uuid

  data_type: 'uuid'
  default_value: uuid_generate_v4()
  is_nullable: 0
  size: 16

=head2 name

  data_type: 'text'
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
  "name",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</uuid>

=back

=cut

__PACKAGE__->set_primary_key("uuid");

=head1 RELATIONS

=head2 user_roles

Type: has_many

Related object: L<Kinohod::Model::Schema::Result::UserRole>

=cut

__PACKAGE__->has_many(
  "user_roles",
  "Kinohod::Model::Schema::Result::UserRole",
  { "foreign.role_uuid" => "self.uuid" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user_uuids

Type: many_to_many

Composing rels: L</user_roles> -> user_uuid

=cut

__PACKAGE__->many_to_many("user_uuids", "user_roles", "user_uuid");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-08-17 14:01:08
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:cdi0p7JMUckJisKgoRSfWQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
