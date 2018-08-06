From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 06 Aug 2018 13:09:02 +0000
Subject: Re: [PATCH v2 3/3] sparc32: split ramdisk detection and reservation to a helper function
Message-Id: <20180806130902.GB23652@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1533552755-16679-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1533552755-16679-4-git-send-email-rppt@linux.vnet.ibm.com>
In-Reply-To: <1533552755-16679-4-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>, Michal Hocko <mhocko@kernel.org>, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 01:52:35PM +0300, Mike Rapoport wrote:
> The detection and reservation of ramdisk memory were separated to allow
> bootmem bitmap initialization after the ramdisk boundaries are detected.
> Since the bootmem initialization is removed, the reservation of ramdisk
> memory is done immediately after its boundaries are found.
> 
> Split the entire block into a separate helper function.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

