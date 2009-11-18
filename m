From: David Miller <davem@davemloft.net>
Date: Wed, 18 Nov 2009 17:55:26 +0000
Subject: Re: [PATCH 06/16] SPARC: use ACCESS_ONCE for rlimits
Message-Id: <20091118.095526.43570583.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4B040A03.2020508@gmail.com>
	<1258555922-2064-6-git-send-email-jslaby@novell.com>
In-Reply-To: <1258555922-2064-6-git-send-email-jslaby@novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jslaby@novell.com
Cc: jirislaby@gmail.com, mingo@elte.hu, nhorman@tuxdriver.com, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, marcin.slusarz@gmail.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, torvalds@linux-foundation.org, jmorris@namei.org, heiko.carstens@de.ibm.com, sparclinux@vger.kernel.org

From: Jiri Slaby <jslaby@novell.com>
Date: Wed, 18 Nov 2009 15:51:52 +0100

> Make sure compiler won't do weird things with limits. E.g. fetching
> them twice may return 2 different values after writable limits are
> implemented.
> 
> Signed-off-by: Jiri Slaby <jslaby@novell.com>

Acked-by: David S. Miller <davem@davemloft.net>

But I wonder have we really seen the compiler create this
kind of situation?  Or is this patch series based upon the
fact that it "could happen"?
