From: David Brown <davidb@codeaurora.org>
Date: Tue, 20 Nov 2012 17:06:25 +0000
Subject: Re: [PATCH 429/493] tty: remove use of __devexit
Message-Id: <20121120170624.GF21706@codeaurora.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-429-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-429-git-send-email-wfp5p@virginia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Nov 19, 2012 at 01:26:18PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit is no
> longer needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> ---
>  drivers/tty/serial/msm_serial.c             |  2 +-
>  drivers/tty/serial/msm_serial_hs.c          |  2 +-

Acked-by: David Brown <davidb@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
