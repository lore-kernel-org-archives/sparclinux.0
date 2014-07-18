From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 18 Jul 2014 16:08:03 +0000
Subject: Re: [PATCH v3] sparc: Add support for seek and shorter read to /dev/mdesc
Message-Id: <20140718160802.GA21385@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1405696541-25189-1-git-send-email-khalid.aziz@oracle.com>
In-Reply-To: <1405696541-25189-1-git-send-email-khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jul 18, 2014 at 09:15:40AM -0600, Khalid Aziz wrote:
> /dev/mdesc on Linux does not support reading arbitrary number
> of bytes and seeking while /dev/mdesc on Solaris does. This
> causes tools that work on Solaris to break on Linux. This patch
> adds these two capabilities to /dev/mdesc.
> 
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>

Thanks,
	Sam
