From: till varoquaux <tvaroqua@ie2.u-psud.fr>
Date: Wed, 07 Jul 2004 14:06:43 +0000
Subject: Re: initrd problems??
Message-Id: <20040707160643.6f6c2eff.tvaroqua@ie2.u-psud.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <20040701194809.3e060eb0.tvaroqua@ie2.u-psud.fr>
In-Reply-To: <20040701194809.3e060eb0.tvaroqua@ie2.u-psud.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Ok I think Ipretty much narrowed down the problem:
It seems the kernel executes /sbin/init instead of /linuxrc in the
initrd (at least for version 2.4.26). It also behaves very weirdly when
it cannot find /sbin/init.
Could anyone double check that for me.
Cheers,
Till
