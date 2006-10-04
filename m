From: Jurij Smakov <jurij@wooyd.org>
Date: Wed, 04 Oct 2006 03:21:49 +0000
Subject: Re: Problems with qla2xxx drivers in recent kernels
Message-Id: <20061004032149.GA4772@droopy.oc.cox.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20061003045359.GA4269@droopy.oc.cox.net>
In-Reply-To: <20061003045359.GA4269@droopy.oc.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Oct 03, 2006 at 09:44:36AM -0300, Gustavo Zacarias wrote:

> Did you build said kernels with CONFIG_SCSI_QLA2XXX_EMBEDDED_FIRMWARE
> enabled? From what we've seen it's required for them to work on those
> machines.

Hi Gustavo,

Thanks for the tip. It is most probably a firmware issue (I've asked to verify 
that). However, I don't think that the config option you mentioned does anything 
useful. I was able to find its only occurence in the 2.6.18 tree in

arch/ia64/configs/sn2_defconfig

Am I missing something here?

Best regards,
-- 
Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
