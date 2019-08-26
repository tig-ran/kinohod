use uni::perl qw| :dumper |;
use Test::More;
use Kinohod::Test;


my $t = Kinohod::Test->new();

my $created_item;

subtest 'create' => sub {
    my $true_json = {
        name      => 'Кинотеатр_' . rand(999999),
        type      => 1,
        is_active => 1,
    };

    my $res = $t->post_ok('/platform',
                            { data =>
                                { type       => 'platform',
                                  attributes => $true_json
                                }
                            });

    is($res->code, 201, '201 created');

    $created_item = $res->{json}{data}{item};

    for ( keys %$true_json ){
        is($created_item->{$_}, $true_json->{$_}, "field [$_] match" );
    }

};

subtest 'get' => sub {

    my $res = $t->get_ok("/platform?uuid=$created_item->{uuid}");

    is($res->code, 200, 'success');

    is( $res->{json}->{data}->{item}{uuid}, $created_item->{uuid}, 'ID matched');

};

subtest 'update' => sub {

    my $new_name = $created_item->{name} . "_updated";

    my $res = $t->patch_ok("/platform" =>
                            { data =>
                                { type       => 'platform',
                                  id         => $created_item->{uuid},
                                  attributes => {
                                    uuid => $created_item->{uuid},
                                    name => $created_item->{name} . "_updated"
                                  }
                                }
                            });

    is($res->code, 200, 'success');

    is( $res->{json}->{data}->{item}{name}, $new_name, 'name updated');
};

subtest 'delete' => sub {

    my $res = $t->delete_ok("/platform?uuid=$created_item->{uuid}");

    is($res->code, 200, 'success');

    is( $res->{json}->{data}->{item}{uuid}, $created_item->{uuid}, 'ID matched');

    my $res = $t->delete_ok("/platform?uuid=$res->{json}->{data}->{item}{uuid}");

    is($res->code, 404, 'item deleted');

};

done_testing();
