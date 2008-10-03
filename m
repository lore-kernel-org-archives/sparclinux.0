From: David Miller <davem@davemloft.net>
Date: Fri, 03 Oct 2008 20:40:17 +0000
Subject: Re: clock_tick printing in cpuinfo
Message-Id: <20081003.134017.193706144.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081002212059.GA13635@orion.carnet.hr>
In-Reply-To: <20081002212059.GA13635@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Thu, 2 Oct 2008 23:20:59 +0200

> So, the attached trivial patch would seem like a good idea to make sparc64
> cpuinfo output just a wee bit easier on the eyes :)
> 
> Maybe there is userland software that absolutely depends on the old format,
> which would preclude applying this patch? That would be pretty strange, but
> I suppose it's possible... Googling found me
> https://ssl.drqueue.org/project/changeset/2027 but that is an open-source
> program where this "regression" could be easily fixed (also they could
> probably simplify their string handling).

GLIBC parses this value for the clock timer interfaces, be careful.
