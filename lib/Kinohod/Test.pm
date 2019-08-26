package Kinohod::Test;

use Test::More;
use JSON::XS qw/ decode_json encode_json/;
use Catalyst::Test 'Kinohod';
use HTTP::Request::Common;


sub new {
    return bless {
        Content_Type => 'application/vnd.api+json',
    }, shift;
}

sub content_type {
    my ( $self, $new_content_type ) = @_;

    if ( $new ){
        $self->{Content_Type} = $new_content_type;
    }

    return $self->{Content_Type};

}

sub post_ok {
    my ($self, $path, $params) = @_;

    return $self->req('POST', $path, $params );

}

sub get_ok {
    my ($self, $path, $params) = @_;

    return $self->req('GET', $path, $params );
}

sub patch_ok {
    my ($self, $path, $params) = @_;

    return $self->req('PATCH', $path, $params );
}

sub delete_ok {
    my ($self, $path, $params) = @_;

    return $self->req('DELETE', $path, $params );
}

sub req {
    my ( $self, $method, $path, $params ) = @_;

    my %request_params = (
        Content_Type => $self->content_type,
    );

    $request_params{Content} = encode_json($params)
        if $params;

    my $res = request(
            ("HTTP::Request::Common::@{[ uc($method) ]}")->(
             $path,
             %request_params
            )
        );

    my $content = $res->content;
    ok($res, "@{[ uc($method) ]} $path");
    $res->{json} = eval { decode_json($res->content); };
    ok($res->{json}, 'RESPONSE is JSON');
    return $res;
}

1;
