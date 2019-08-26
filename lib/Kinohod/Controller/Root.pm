package Kinohod::Controller::Root;
use Moose;
use namespace::autoclean;
use uni::perl qw(:dumper);

BEGIN { extends 'Catalyst::Controller' }

__PACKAGE__->config(namespace => '');

our %http_method_map = (
    GET => 'get',
    POST => 'create',
    PATCH => 'update',
    DELETE => 'delete'
);

sub base : Chained( '' ) : PathPart( '' ) : CaptureArgs( 0 ) {
    my ( $self, $c ) = @_;

    $c->set_params();
}

sub auth : Chained( 'base' ) : PathPart( '' ) : CaptureArgs( 0 ) {
    my ( $self, $c ) = @_;

}

=head2 index

The root page (/)

=cut

sub login : Chained( '' ) : PathPart( 'login' ) : CaptureArgs( 0 ) {
    my ( $self, $c ) = @_;

}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;

    $c->set_params();

    my $model;
    if ( $c->req->arguments->[-1] ){
        $model = $c->model( $c->req->arguments->[-1] );
    }

    $c->detach('/errors', [404, 'Page not found'])
        unless $model;

    my $method = $http_method_map{ $c->req->method };

    $c->detach('/errors', [400, "HTTP method @{[ $c->req->method  ]} not supported" ])
        unless $method;

    my ( $res, $errors ) = $model->$method($c->req->params);

    $c->detach('/errors', [ ( exists $errors->{id} && $errors->{id} eq 'not_found' ? 404 : 400 ),
                            $errors
                          ])
        if $errors;

    $c->stash->{data} = $res;
    $c->res->status(201) if $method eq 'create';
}

sub end : ActionClass( 'RenderView' ) {
    my ( $self, $c ) = @_;

    $c->res->status($c->stash->{data} ? 200 : 400)
        unless $c->res->status;
}

sub errors : Path('/errors') : Args(1) {
    my ($self, $c, $status, $errors) = @_;

    $c->stash->{data} = {
        errors => $errors
    };

    $c->res->status($status);
}

=head1 AUTHOR

Tigran,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
