From: David Dillow <dave@thedillows.org>
Date: Wed, 11 Feb 2004 06:47:23 +0000
Subject: Re: Fix for exception length errors in sparc64 copy_*_user()
Message-Id: <1076482043.4940.0.camel@ori.thedillows.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040210215900.5078d229.davem@redhat.com>
In-Reply-To: <20040210215900.5078d229.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 2004-02-11 at 00:59, David S. Miller wrote:
> OK, the patch below should fix the problem and thus the AIO
> testsuite failures on sparc64.

Confirmed; thanks for the fix!

Dave
