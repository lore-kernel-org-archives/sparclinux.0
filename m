From: David Miller <davem@davemloft.net>
Date: Thu, 15 Jun 2017 15:21:29 +0000
Subject: Re: [v1 0/2] Early boot timestamp fixes
Message-Id: <20170615.112129.1268181207527338555.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1497537659-419752-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1497537659-419752-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 15 Jun 2017 10:40:57 -0400

> Guenter Roeck reported a problem that was introduced by early boot
> timestamp changes. Where: tick_get_frequency() returns 0.
> 
> Guenter Roeck: could you please test if these patches fix the issue?

I'll push this to sparc-next as soon as Guenter tests it.

Thanks.
