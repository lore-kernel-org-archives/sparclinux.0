From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Wed, 31 Mar 2004 02:40:41 +0000
Subject: Re: Compiling sunlance as a module
Message-Id: <20040331024041.GB31163@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040330234412.GB5439@artsapartment.org>
In-Reply-To: <20040330234412.GB5439@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Mar 30, 2004 at 07:38:32PM -0600, Art Haas wrote:

> I try to make the kernel as modular as I can, so that's why I'm trying
> to build this driver as a module. It's just how I tend to configure
> things ...

alias eth0 sunlance

SEE ALSO

modules.conf(5), modprobe(8)

I guess hotplug is the pocket calculator of system configuration.

-- 
Keith M Wesolowski
