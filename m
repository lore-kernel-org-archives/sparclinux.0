From: Matthew Wilcox <willy@infradead.org>
Date: Fri, 15 May 2020 18:43:58 +0000
Subject: Re: [PATCH v2] Implement close-on-fork
Message-Id: <20200515184358.GH16070@bombadil.infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200515152321.9280-1-nate.karstens@garmin.com>
 <20200515155730.GF16070@bombadil.infradead.org>
 <5b1929aa9f424e689c7f430663891827@garmin.com>
 <1589559950.3653.11.camel@HansenPartnership.com>
 <4964fe0ccdf7495daf4045c195b14ed6@garmin.com>
In-Reply-To: <4964fe0ccdf7495daf4045c195b14ed6@garmin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Karstens, Nate" <Nate.Karstens@garmin.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, David Laight <David.Laight@aculab.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, sparclinux@vger.k

On Fri, May 15, 2020 at 06:28:20PM +0000, Karstens, Nate wrote:
> Our first attempt, which was to use the pthread_atfork() handlers, failed because system() is not required to call the handlers.
> 
> Most of the feedback we're getting on this seems to say "don't use system(), it is unsafe for threaded applications". Is that documented anywhere? The man page says it is "MT-Safe".

https://pubs.opengroup.org/onlinepubs/9699919799/functions/system.html

> Aside from that, even if we remove all uses of system() from our application (which we already have), then our application, like many other applications, needs to use third-party shared libraries. There is nothing that prevents those libraries from using system(). We can audit those libraries and go back with the vendor with a request to replace system() with a standard fork/exec, but they will also want documentation supporting that.

They might also be using any number of other interfaces which aren't
thread-safe.

> If the feedback from the community is truly and finally that system() should not be used in these applications, then is there support for updating the man page to better communicate that?

Yes, absolutely.

I think you're mischaracterising our feedback.  It's not "We don't want
to fix this interface".  It's "We don't want to slow down everything else
to fix this interface (and by the way there are lots of other problems
with this interface that you aren't even trying to address)".
