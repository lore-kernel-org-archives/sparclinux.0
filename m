From: "C.Newport" <crn@netunix.com>
Date: Wed, 09 Jun 2004 10:44:40 +0000
Subject: Re: Anyone using Linux on Sun E10k ?
Message-Id: <200406091144.40695.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040609101606.GW6658@magicbluesmoke.net>
In-Reply-To: <20040609101606.GW6658@magicbluesmoke.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wednesday 09 June 2004 11:16 am, John P. Looney wrote:
>  Hi, I'd like to hear from anyone that's used Linux on E10k systems in
> production. How reliable it is, how much of the E10k's functionality do
> you get, compared to Solaris etc. (mail me off list, if this isn't really
> on topic).

I did some tests a few years ago using 2.2.x and it all worked well after
rebuilding the kernel to support more CPUs.
2.2 did not scale well beyond about 16 CPUs but this should now be
improved.

FC and FCAL are both broken in 2.4 and 2.6 so your storage options
are rather limited until this gets fixed. [could someone with the required 
skills please pick up this ball, the maintainer seems to have vanished].

The big killer is that Linux has no support for Dynamic Reconfiguration
so you cannot pull boards or move resources between domains without
shutting down the system. It may be possible to hack the Linux hotplug
system to do DR but this sounds like a major project. 
Ditto Dynamic Multipathing and InterDomain Networking.

