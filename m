From: Josip Rodin <joy@entuzijast.net>
Date: Fri, 26 Oct 2007 22:32:51 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <20071026223251.GA6144@keid.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Oct 26, 2007 at 03:01:24PM -0700, David Miller wrote:
> One thing I notice in the debian bug report is a mention of libnss-db
> 
> So I did some testing here and without libnss-db installed, running
> dpkg-query does not use futexes at all.
> 
> But once I install libnss-db and enable it (by running 'make' under
> /var/lib/misc then editing /etc/nsswitch.conf to make 'db' get
> searched first) indeed dpkg-query starts using futexes via the
> libnss-db library.
> 
> Josip, do you guys have libnss-db or similar in use on the buildd
> machine?

lebrun.d.o doesn't have libnss-db installed, neither outside nor inside
the chroot, sorry.

Both setups have the default /etc/nsswitch.conf that searches 'db' before
'files' for protocols, services, ethers, rpc, but that's it.

BTW, would you benefit from having an account on this machine?

-- 
     2. That which causes joy or happiness.
