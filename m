From: Frans Pop <elendil@planet.nl>
Date: Wed, 18 Jun 2008 10:50:58 +0000
Subject: Re: disks on Ultra/1 not detected with esp_scsi on 2.6.24
Message-Id: <200806181250.59368.elendil@planet.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <20080412093242.GP3535@bayworld.net>
In-Reply-To: <20080412093242.GP3535@bayworld.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> The following looks suspicious:
> Apr 12 07:11:58 hw-detect: Missing modules 'esp (ESP SCSI), usb-storage
> (USB storage)
> 
> The esp_scsi module seems to have been loaded, but the sun_esp module
> did not.  This is probably what the problem is.

Correct. We made a mistake while updating Debian Installer after the 
esp -> sun_esp rename, thinking that the rename was to esp_scsi.
The sun_esp module is currently not even included in installer images.

As it happens this was fixed yesterday in SVN and daily built Debian 
Installer images should be fixed as soon as we switch over to 2.6.25, 
which should be within the next two weeks or so.

Sorry for any inconvenience.

Cheers,
FJP
