From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 18 Jan 2011 19:43:17 +0000
Subject: Re: [PATCH 6/6 V3] sparc: Fix sbus_alloc_coherent error handling.
Message-Id: <20110118194317.GF15969@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1295359829-27308-7-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1295359829-27308-7-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Jan 18, 2011 at 03:10:29PM +0100, Kristoffer Glembo wrote:
> Order of kfree and free_pages were swapped in the error handling.
Well spotted!

Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
