package Kinohod::Plugin::Utils;

sub set_params {
    my $c = shift;

    if ($c->req->body_data &&
        exists $c->req->body_data->{data} &&
        exists $c->req->body_data->{data}{attributes} &&
        ref $c->req->body_data->{data}{attributes} eq 'HASH'
        ){
        for ( keys %{ $c->req->body_data->{data}{attributes} }){
            $c->req->params->{$_} = $c->req->body_data->{data}{attributes}->{$_}
                unless exists $c->req->params->{$_};
        }
    }
}

1;
