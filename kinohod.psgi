use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";

use Kinohod;

my $app = Kinohod->apply_default_middlewares(Kinohod->psgi_app);
$app;

