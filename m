From: Christoph Hellwig <hch@infradead.org>
Date: Sun, 18 Aug 2019 07:01:37 +0000
Subject: Re: sparc64: hang from BUG: Bad page state, on older CPU & compiler
Message-Id: <20190818070137.GA22731@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <d2a51bfb-84e4-3ce7-ac48-7200b3a8d722@linux.ee>
In-Reply-To: <d2a51bfb-84e4-3ce7-ac48-7200b3a8d722@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I think for now we'll simply have to disable HAVE_FAST_GUP for sparc,
until someone who really knows low-level sparc page table handling
finds some time to audit the generic fast gup code and arch hooks.
