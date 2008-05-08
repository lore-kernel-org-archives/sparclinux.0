From: Olaf Hering <olaf@aepfle.de>
Date: Thu, 08 May 2008 21:31:01 +0000
Subject: Re: [PATCH v5] create modalias file in sysfs for bus of_platform
Message-Id: <20080508213101.GA8848@aepfle.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20080122142109.GA12967@aepfle.de>
	<20080122144053.GA13019@aepfle.de>
	<20080122190939.GA14124@aepfle.de>
	<18330.32110.449914.354218@cargo.ozlabs.ibm.com>
	<20080126100427.GA1162@aepfle.de>
	<20080424131600.GA15226@aepfle.de>
In-Reply-To: <20080424131600.GA15226@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mackerras <paulus@samba.org>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org

On Thu, Apr 24, Olaf Hering wrote:

> Create /sys/bus/of_platform/devices/*/modalias file to allow autoloading
> of modules. modalias files are already present for many other bus types.
> This adds also a newline to the devspec files.
> 
> Also create a devspec file for mac-io devices. They were created as a side
> effect. Use correct buffer size for mac-io modalias buffer.
> 
> Tested on iBook1 and Efika.

Did anyone test this on other systems, like sparc?
