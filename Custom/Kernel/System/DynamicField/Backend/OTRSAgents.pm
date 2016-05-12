# --
# Kernel/System/DynamicField/Backend/OTRSAgents.pm - Delegate for DynamicField OTRSAgents Backend
# Copyright (C) 2016 Perl-Services.de, http://perl-services.de
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::DynamicField::Backend::OTRSAgents;

use strict;
use warnings;

use Kernel::System::VariableCheck qw(:all);
use Kernel::System::DynamicFieldValue;

use base qw(Kernel::System::DynamicField::Backend::Dropdown);


=head1 NAME

Kernel::System::DynamicField::Backend::OTRSAgents

=head1 SYNOPSIS

DynamicFields OTRSAgents Backend delegate

=head1 PUBLIC INTERFACE

This module implements the public interface of L<Kernel::System::DynamicField::Backend>.
Please look there for a detailed reference of the functions.

=over 4

=item new()

usually, you want to create an instance of this
by using Kernel::System::DynamicField::Backend->new();

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    # get needed objects
    for my $Needed (qw(ConfigObject EncodeObject LogObject MainObject DBObject TimeObject UserObject)) {
        die "Got no $Needed!" if !$Param{$Needed};

        $Self->{$Needed} = $Param{$Needed};
    }

    # create additional objects
    $Self->{DynamicFieldValueObject} = Kernel::System::DynamicFieldValue->new( %{$Self} );

    return $Self;
}

sub ValueSet {
    my ($Self, %Param) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet( %Param );

    return $Self->SUPER::ValueSet( %Param );
}

sub EditFieldValueValidate {
    my ($Self, %Param) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet( %Param );

    return $Self->SUPER::EditFieldValueValidate( %Param );
}

sub DisplayValueRender {
    my ($Self, %Param) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet( %Param );

    return $Self->SUPER::DisplayValueRender( %Param );
}

sub SearchFieldRender {
    my ($Self, %Param) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet( %Param );

    return $Self->SUPER::SearchFieldRender( %Param );
}

sub SearchFieldParameterBuild {
    my ($Self, %Param) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet( %Param );

    return $Self->SUPER::SearchFieldParameterBuild( %Param );
}

sub StatsFieldParameterBuild {
    my ($Self, %Param) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet( %Param );

    return $Self->SUPER::StatsFieldParameterBuild( %Param );
}

sub ValueLookup {
    my ($Self, %Param) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet( %Param );

    return $Self->SUPER::ValueLookup( %Param );
}

sub ColumnFilterValuesGet {
    my ($Self, %Param) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet( %Param );

    return $Self->SUPER::ColumnFilterValuesGet( %Param );
}

sub PossibleValuesGet {
    my ($Self, %Param) = @_;

    my $UserObject = $Self->{UserObject};

    my $Config = $Param{DynamicFieldConfig}->{Config} || {};

    my %List = $UserObject->UserList(
        Type          => 'Long',
        Valid         => 1,
        NoOutOfOffice => 1,
    );

    my $FieldPossibleNone;
    if ( defined $Param{OverridePossibleNone} ) {
        $FieldPossibleNone = $Param{OverridePossibleNone};
    }
    else {
        $FieldPossibleNone = $Config->{PossibleNone} || 0;
    }

    # set none value if defined on field config
    if ($FieldPossibleNone) {
        $List{''} = '-';
    }


    return \%List;
}

1;

=back

=head1 TERMS AND CONDITIONS

This software comes with ABSOLUTELY NO WARRANTY. For details, see
the enclosed file COPYING for license information (AGPL). If you
did not receive this file, see L<http://www.gnu.org/licenses/agpl.txt>.

=cut
