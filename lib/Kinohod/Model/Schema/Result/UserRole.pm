use utf8;
package Kinohod::Model::Schema::Result::UserRole;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Kinohod::Model::Schema::Result::UserRole

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

=head1 TABLE: C<user_roles>

=cut

__PACKAGE__->table("user_roles");

=head1 ACCESSORS

=head2 user_uuid

  data_type: 'uuid'
  is_foreign_key: 1
  is_nullable: 0
  size: 16

=head2 role_uuid

  data_type: 'uuid'
  is_foreign_key: 1
  is_nullable: 0
  size: 16

=cut

__PACKAGE__->add_columns(
  "user_uuid",
  { data_type => "uuid", is_foreign_key => 1, is_nullable => 0, size => 16 },
  "role_uuid",
  { data_type => "uuid", is_foreign_key => 1, is_nullable => 0, size => 16 },
);

=head1 PRIMARY KEY

=over 4

=item * L</user_uuid>

=item * L</role_uuid>

=back

=cut

__PACKAGE__->set_primary_key("user_uuid", "role_uuid");

=head1 RELATIONS

=head2 role_uuid

Type: belongs_to

Related object: L<Kinohod::Model::Schema::Result::Role>

=cut

__PACKAGE__->belongs_to(
  "role_uuid",
  "Kinohod::Model::Schema::Result::Role",
  { uuid => "role_uuid" },
  { is_deferrable => 0, on_delete => "RESTRICT", on_update => "NO ACTION" },
);

=head2 user_uuid

Type: belongs_to

Related object: L<Kinohod::Model::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user_uuid",
  "Kinohod::Model::Schema::Result::User",
  { uuid => "user_uuid" },
  { is_deferrable => 0, on_delete => "RESTRICT", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-08-17 14:01:08
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:TQfc05ZBPcOCHhLWG/DIgg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
