From: "David S. Miller" <davem@redhat.com>
Date: Wed, 21 Jul 2004 20:34:06 +0000
Subject: Re: [RFC PATCH] Allow larger than 1MB mappings on sparc64 sbus
Message-Id: <20040721133406.6ebc78cd.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1089341045.3100.38.camel@ori.thedillows.org>
In-Reply-To: <1089341045.3100.38.camel@ori.thedillows.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 08 Jul 2004 22:44:05 -0400
David Dillow <dave@thedillows.org> wrote:

> I've modified the allocator to allow mappings up to 127MB (or
> thereabouts). It will allocate a contiguous run of clusters to allow the
> mapping of the request, and return NULL if it is unable to do so. This
> also modifies the deallocator to return those ioptes to the pool.

I've put this patch into my tree, thanks David.
