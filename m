From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 10 Jun 2006 19:47:30 +0000
Subject: Re: Sun Blade 2500
Message-Id: <Pine.LNX.4.63.0606101240280.2781@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.63.0606021919280.2727@bobcat>
In-Reply-To: <Pine.LNX.4.63.0606021919280.2727@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 6 Jun 2006, David Miller wrote:

> From: Tobias Marx <tmarx@uni-wuppertal.de>
> Date: Tue, 06 Jun 2006 19:08:25 +0200
>
>> do you know what the module for this is called?
>
> mptsas.ko, enabled by config option CONFIG_FUSION_SAS

Tom Marble of Sun sent me the lsmod and lspci output from his Blade2500 
machine (thanks, Tom!). It turns out that it has both an IDE controller 
(alim15x3 driver) and a SCSI controller (sym53c8xx and scsi_transport_spi 
modules). All these modules are currently included in the installer, so 
it's still not clear why the Debian installer fails to detect them. 
Tobias, can you please try loading these modules manually, and look at 
kernel/installer logs to see what's happening?

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
