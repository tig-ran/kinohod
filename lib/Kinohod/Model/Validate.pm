package Kinohod::Model::Validate;
use strict;
use warnings;

sub new {
    return bless {}, shift;
}

sub validate {
    my ( $self, $result_source, $params ) = @_;

    my %columns = map { $_ => $result_source->column_info( $_ ) }
                  $result_source->columns;

    my ( $res, $errors );
    for my $column ( keys %columns ){

        next if $columns{$column}->{readonly};

        if ( not defined $params->{$column} ){
            if ( $columns{$column}->{is_nullable} ){
                next;
            }

            $errors->{$column} = 'required';
            next;
        }

        my $validation_method = "validate_$columns{$column}->{data_type}";
        $res->{$column} = $self->$validation_method($params->{$column});

        unless ( $res->{$column} ){
            $errors->{$column} = 'invalid';
        }

    }

    return (undef, $errors ) if keys %$errors;

    return ( $res, undef );
}

sub validate_uuid {
    my ( $self, $uuid ) = @_;
    return $uuid =~ /^[a-f0-9]{8}\-[a-f0-9]{4}\-[a-f0-9]{4}\-[a-f0-9]{4}\-[a-f0-9]{12}$/
            ? $uuid
            : undef;
}

sub validate_integer {
    my ( $self, $int ) = @_;
    return $int =~ /^\d+$/
            ? $int
            : undef;
}

sub validate_boolean {
    my ( $self, $boolean ) = @_;
    return unless $boolean =~ /^(?:0|1|true|false)$/;
    return 1 if $boolean eq "true";
    return 0 if $boolean eq "false";
    return $boolean ? 1 : 0;
}

sub validate_text {
    my ( $self, $text ) = @_;
    $text ||= "";
    $text =~ s/^\s+//;
    $text =~ s/\s+$//;
    return $text;
}



1;
