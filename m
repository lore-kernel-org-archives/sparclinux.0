From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date: Sat, 23 Feb 2008 11:36:33 +0000
Subject: Re: [PATCH 1/2] firewire: endianess fix
Message-Id: <tkrat.e867721c03e156c2@s5r6.in-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20080220220326.GA22328@uranus.ravnborg.org>
	<1203545913.25307.47.camel@brick>
	<tkrat.e2bfb30f2c0ae70a@s5r6.in-berlin.de>
	<tkrat.9e19fa31951506af@s5r6.in-berlin.de>
In-Reply-To: <tkrat.9e19fa31951506af@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux1394-devel@lists.sourceforge.net
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, Jarod Wilson <jwilson@redhat.com>, Sam Ravnborg <sam@ravnborg.org>, Harvey Harrison <harvey.harrison@gmail.com>

I wrote:
> If possible, also test whether the device remains accessible after
> forcing a bus reset, e.g. by "echo br short > firecontrol".

"echo br short | firecontrol" of course.

This test should actually not really be necessary because simply
plugging the SBP-2 device in should already cause enough generation
changes for the code to trip over an endianess bug before or after thhe
patch, me thinks.
-- 
Stefan Richter
-===-=--- --=- =-=http://arcgraph.de/sr/

