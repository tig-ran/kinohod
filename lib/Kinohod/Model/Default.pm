package Kinohod::Model::Default;
use parent 'Kinohod::Model::DB';
use strict;
use warnings;

use Scalar::Util qw(blessed);

sub create {
    my ( $self, $params, $resultset_name ) = @_;

    my $resultset = $self->get_resultset($resultset_name);

    my ( $fields, $errors ) = $self->validator
                                    ->validate($resultset->result_source,
                                               $params
                                             );

    return ( undef, $errors ) if $errors;

    my $item = $resultset->create($fields);

    return ( { item => $self->to_hash($item) }, undef );
}

sub get {
    my ( $self, $params, $resultset_name ) = @_;

    return ( undef, { id => 'invalid' } )
        unless $self->validator->validate_uuid($params->{uuid});

    my $item = $self->get_resultset($resultset_name)
                    ->search({ uuid => $params->{uuid} })
                    ->first;

    return ( undef, { id => 'not_found' } )
        unless $item;

    return ( { item => $self->to_hash($item) }, undef );
}

sub update {
    my ( $self, $params, $resultset_name ) = @_;

    return ( undef, { id => 'invalid' } )
        unless $self->validator->validate_uuid($params->{uuid});

    my $resultset = $self->get_resultset($resultset_name);

    my $item = $resultset->search({ uuid => $params->{uuid} })
                         ->first;

    return ( undef, { id => 'not_found' } )
        unless $item;

    for my $column ( $resultset->result_source->columns ){
        next if exists $params->{$column};
        $params->{$column} = $item->$column;
    }

    my ( $fields, $errors ) = $self->validator
                                    ->validate($resultset->result_source,
                                               $params
                                             );

    return ( undef, $errors ) if $errors;

    $item->update($fields);

    return ( { item => $self->to_hash($item) }, undef );
}

sub delete {
    my ( $self, $params, $resultset_name ) = @_;

    return ( undef, { id => 'invalid' } )
        unless $self->validator->validate_uuid($params->{uuid});

    my $item = $self->get_resultset($resultset_name)
                    ->search({ uuid => $params->{uuid} })
                    ->first;

    return ( undef, { id => 'not_found' } )
        unless $item;

    $item->delete;

    return ( { item => $self->to_hash($item) }, undef );
}

sub get_resultset {
    my ( $self, $resultset_name ) = @_;

    unless ( $resultset_name ){
        my $class = blessed( $self );
        $class =~ s/^Kinohod::Model:://;
        $resultset_name = $class;
    }

    return $self->schema
                ->resultset( $resultset_name );
}


1;
