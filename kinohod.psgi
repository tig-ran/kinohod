use strict;
use warnings;

use Kinohod;

my $app = Kinohod->apply_default_middlewares(Kinohod->psgi_app);
$app;

