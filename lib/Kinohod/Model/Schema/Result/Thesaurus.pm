use utf8;
package Kinohod::Model::Schema::Result::Thesaurus;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Kinohod::Model::Schema::Result::Thesaurus

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

=head1 TABLE: C<thesaurus>

=cut

__PACKAGE__->table("thesaurus");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'thesaurus_id_seq'

=head2 entity_id

  data_type: 'integer'
  is_nullable: 0

=head2 entity_type

  data_type: 'text'
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 note

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "thesaurus_id_seq",
  },
  "entity_id",
  { data_type => "integer", is_nullable => 0 },
  "entity_type",
  { data_type => "text", is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 0 },
  "note",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<thesaurus_entity_id_entity_type_key>

=over 4

=item * L</entity_id>

=item * L</entity_type>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "thesaurus_entity_id_entity_type_key",
  ["entity_id", "entity_type"],
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-08-17 14:01:08
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:V+ceG3DEIpsmaTNXTz1jGA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
