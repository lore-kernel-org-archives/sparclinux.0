From: Ben Collins <ben.collins@ubuntu.com>
Date: Fri, 18 May 2007 22:01:20 +0000
Subject: Re: How to load 2.6.22 kernel (image too large to fit ...)
Message-Id: <1179525680.6510.277.camel@cunning>
List-Id: <sparclinux.vger.kernel.org>
References: <464d3ea78cfe8@wp.pl>
In-Reply-To: <464d3ea78cfe8@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 2007-05-19 at 23:44 +0200, Krzysztof Helt wrote:
> Hi again,
> 
> I overcame the problem with too big kernel with the attached patch, but 
> I run into another problem. Now, the silo says:
> 
> "Your kernel cannot fit into the memory destination. This
> can be resolved by recompiling the kernel with more devices
> built as modules, or upgrading your kernel to one that
> supports being loaded to higher memory areas (currently
> 2.6.3+ or 2.4.26+)."
> 
> Does it mean, that 2.6.22-rc1 for sparc32 cannot be relocated?

The patch isn't complete. SILO checks to make sure that the kernel can
be relocated. You probably also need to patch up sparc kernel to allow
itself to be loaded at an alternate location. Whole lot of work.

Honestly, just compile it with less stuff. I don't have a sparc32 to
test anything on, so I'm of no help.

-- 
Ubuntu   : http://www.ubuntu.com/
Linux1394: http://wiki.linux1394.org/

