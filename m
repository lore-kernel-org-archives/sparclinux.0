From: "David S. Miller" <davem@redhat.com>
Date: Wed, 26 May 2004 18:15:25 +0000
Subject: Re: 2.6.6: compile error with spinlock debugging
Message-Id: <20040526111525.251155c6.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.44.0405121404550.3243-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0405121404550.3243-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 26 May 2004 20:22:24 +0300 (EEST)
Meelis Roos <mroos@linux.ee> wrote:

> > This should fix the problem:
> 
> arch/sparc64/lib/debuglocks.c: In function `_do_write_trylock':
> arch/sparc64/lib/debuglocks.c:305: warning: unused variable `stuck'
> arch/sparc64/lib/debuglocks.c:307: warning: unused variable `shown'
> make[1]: *** [arch/sparc64/lib/debuglocks.o] Error 1

> Removing these 2 variables makes it compile without errors.

Good catch, fixed in my sources now too.
