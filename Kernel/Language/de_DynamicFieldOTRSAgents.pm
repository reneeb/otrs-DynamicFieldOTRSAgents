# --
# Kernel/Language/de_DynamicFieldOTRSAgents.pm - the german translation of DynamicFieldOTRSAgents
# Copyright (C) 2016 - 2023 Perl-Services, https://www.perl-services.de
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Language::de_DynamicFieldOTRSAgents;

use strict;
use warnings;

use utf8;

sub Data {
    my $Self = shift;

    my $Lang = $Self->{Translation};

    return if ref $Lang ne 'HASH';

    $Lang->{'Valid agents only'} = 'Nur gültige Agenten';
    $Lang->{'PossibleNone'}      = 'Leerer Wert möglich';

    return 1;
}

1;
