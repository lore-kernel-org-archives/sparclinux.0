From: "David S. Miller" <davem@redhat.com>
Date: Tue, 10 Aug 2004 17:55:35 +0000
Subject: Re: /dev/random lacks entropy on sparc64
Message-Id: <20040810105535.2b7a3233.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1092092360.7938.50.camel@duncow>
In-Reply-To: <1092092360.7938.50.camel@duncow>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 11 Aug 2004 02:23:04 +1000
Anton Blanchard <anton@samba.org> wrote:

> I remembered Arnd had a patch to use get_cycles(), this way we avoid
> each architecture defining their own method. How does this look?

Looks fine to me, someone should push this to Linus.
:-)
