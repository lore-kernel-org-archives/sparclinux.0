From: "David S. Miller" <davem@redhat.com>
Date: Mon, 02 Feb 2004 19:02:45 +0000
Subject: Re: the late arch/sparc64/mm/init.c:__flush_cache_all
Message-Id: <20040202110245.20ce1fad.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <87ektjdcu9.fsf@uga.edu>
In-Reply-To: <87ektjdcu9.fsf@uga.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 02 Feb 2004 13:51:38 -0500
Ed L Cashin <ecashin@uga.edu> wrote:

> The manual also says that there are different kinds of addresses,
> cachable and non-cachable, but I don't see any way to say, "Make all
> of the VA's in this process non-cachable."

You make the "virtually cacheable" bit in all PTEs of that process
clear.
