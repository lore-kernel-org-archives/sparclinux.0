From: William Lee Irwin III <wli@holomorphy.com>
Date: Sat, 20 Nov 2004 10:04:03 +0000
Subject: Re: circular console list in 2.6.9-bk3+
Message-Id: <20041120100403.GS2714@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20041118144142.GG2268@holomorphy.com>
In-Reply-To: <20041118144142.GG2268@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Nov 18, 2004 at 07:00:07PM -0800, David S. Miller wrote:
> This should do the trick.  Just do the console init
> before we add the ports.

Just to make sure that sure I explicitly said so, this fixes the
circular console list issue on my boxen.


-- wli
