From: "David S. Miller" <davem@redhat.com>
Date: Fri, 09 Jul 2004 23:57:29 +0000
Subject: Re: [RFC PATCH] Allow larger than 1MB mappings on sparc64 sbus
Message-Id: <20040709165729.5e699084.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1089341045.3100.38.camel@ori.thedillows.org>
In-Reply-To: <1089341045.3100.38.camel@ori.thedillows.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 08 Jul 2004 22:44:05 -0400
David Dillow <dave@thedillows.org> wrote:

> Unfortunately, we only support streaming mappings of up to 1MB in size,
> while printing on letter paper requires up to 1.75MB, and B4 paper
> requires 2.75MB. Worse, if someone asks for more than 1MB, we could
> potentially corrupt memory above the IOMMU page tables.

Does the device require being queued the entire page all at
once or can you send it in pieces some other way?

Your patch looks fine.
