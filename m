From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Fri, 05 Jan 2007 19:35:05 +0000
Subject: Re: [2.6.19.1] ESP regression ?
Message-Id: <1168025705.3161.134.camel@dhcp-32-109.ord.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <459E1EC7.7050300@systella.fr>
In-Reply-To: <459E1EC7.7050300@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 2007-01-05 at 11:45 -0600, Tom 'spot' Callaway wrote:

> For what it is worth, I'm not actually able to get esp.ko (Aurora builds
> esp as a module) working at all on any sparc32 systems (immediate
> testing on ss4 and ss20). 

Building the SCSI and esp components into the kernel does not change the
results, it still doesn't work on 2.6.18.1+ on sparc32.

If anyone has a working sparc32 kernel config that works on a sparc32
w/esp, please post it here.

Thanks,

~spot

