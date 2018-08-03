From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 03 Aug 2018 20:18:16 +0000
Subject: Re: [PATCH 2/2] sparc32: tidy up ramdisk memory reservation
Message-Id: <20180803201816.GB7789@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1533210833-14748-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1533210833-14748-3-git-send-email-rppt@linux.vnet.ibm.com>
In-Reply-To: <1533210833-14748-3-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>, Michal Hocko <mhocko@kernel.org>, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

Hi Mike.

On Thu, Aug 02, 2018 at 02:53:53PM +0300, Mike Rapoport wrote:
> The detection and reservation of ramdisk memory were separated to allow
> bootmem bitmap initialization after the ramdisk boundaries are detected.
> Since the bootmem initialization is removed, the reservation of ramdisk
> memory can be done immediately after its boundaries are found.

When touching this area could you look
at introducing a find_ramdisk() function like
we do for sparc64?
It is always nice when the codebases look alike.
Then you could combine your simplification
with some refactoring that further increases
readability.

See:
https://patchwork.ozlabs.org/patch/151194/
for my attempt from long time ago.

	Sam
