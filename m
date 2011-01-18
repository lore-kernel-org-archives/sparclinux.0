From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 18 Jan 2011 19:37:29 +0000
Subject: Re: [PATCH 2/6 V3] sparc: Add pci32_unmap_page.
Message-Id: <20110118193729.GB15969@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1295359829-27308-3-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1295359829-27308-3-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Jan 18, 2011 at 03:10:25PM +0100, Kristoffer Glembo wrote:
> Signed-off-by: Kristoffer Glembo <kristoffer@gaisler.com>

I am still missing from the changelog this information:

pci32_unmap_page is part of the DMA API and needed by
the leon ethernet driver.

Anyway:
Acked-by: Sam Ravnborg <sam@ravnborg.org>
