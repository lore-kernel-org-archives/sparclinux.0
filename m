From: Konrad Eisele <konrad@gaisler.com>
Date: Wed, 04 Apr 2012 07:30:42 +0000
Subject: Re: Sparc-32 debian wheezy package repository at http://developer.gaisler.net/debian/
Message-Id: <4F7BF8A2.9010106@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4F7BF320.1040506@gaisler.com>
In-Reply-To: <4F7BF320.1040506@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Julian Calaby wrote:
> Hi Konrad,
>
> On Wed, Apr 4, 2012 at 17:07, Konrad Eisele<konrad@gaisler.com>  wrote:
>> Debian wheezy sparc-32 package repository:
>> http://developer.gaisler.net/debian/
>
> Awesome work!
>
>> For cross compilation of debian packages there is a
>> sparc-linux-gnu crosscompiler with many libraries preinstalled:
>> http://developer.gaisler.net/debian/cross-compiler/sparc-linux-gnu-cross_1.0.0-1_amd64.deb
>> This package is for a 64-bit machine.
>
> crosstool-ng (which Sam has contributed Sparc support to) is another
> way to easily build a cross compiler. buildroot is another
> alternative.

The one above has a lot of headers and libxxx-dev-sparc-cross.dev  packages installed by default.
It is a multiarch compiler for debian-64-wheezy. You can build new cross package by:
$apt-get source <name>
$cd <dir>
$dpkg-buildpackage -asparc -us -uc -rfakeroot -b
Then you convert  the .deb to multiarch:
$export CC=sparc-linux-gnu-gcc
and install the "dev" deb oackages:
$dpkg-cross -A -M -a sparc -b <dev-name>.deb
$sudo dpkg -i <dev-name-sparc-cross>.deb
Most of the time you have to fiddle with he buildscripts though.
You need to be in a debian-64 wheezy distribution. (I use a 64-bit virtual virtualbox
and netinst from http://www.debian.org/devel/debian-installer/).

-- Konrad

>
> Thanks,
>

