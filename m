Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57551C61DB3
	for <sparclinux@archiver.kernel.org>; Sat,  7 Jan 2023 01:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjAGBjs (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 6 Jan 2023 20:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjAGBjr (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 6 Jan 2023 20:39:47 -0500
X-Greylist: delayed 206 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 Jan 2023 17:39:46 PST
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499307D9FD;
        Fri,  6 Jan 2023 17:39:45 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pDy88-001Dtj-Oh; Sat, 07 Jan 2023 02:36:16 +0100
Received: from p57bd9807.dip0.t-ipconnect.de ([87.189.152.7] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pDy88-002IA8-GA; Sat, 07 Jan 2023 02:36:16 +0100
Message-ID: <800d35d9-4ced-052e-aebe-683f431356ae@physik.fu-berlin.de>
Date:   Sat, 7 Jan 2023 02:36:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next 0/7] Remove three Sun net drivers
Content-Language: en-US
To:     Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        netdev@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mips@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org, Leon Romanovsky <leon@kernel.org>
References: <20230106220020.1820147-1-anirudh.venkataramanan@intel.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <20230106220020.1820147-1-anirudh.venkataramanan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.152.7
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hello!

On 1/6/23 23:00, Anirudh Venkataramanan wrote:
> This series removes the Sun Cassini, LDOM vswitch and sunvnet drivers.

This would affect a large number of Linux on SPARC users. Please don't!

We're still maintaining an active sparc64 port for Debian, see [1]. So
does Gentoo [2].

> In a recent patch series that touched these drivers [1], it was suggested
> that these drivers should be removed completely. git logs suggest that
> there hasn't been any significant feature addition, improvement or fixes
> to user-visible bugs in a while. A web search didn't indicate any recent
> discussions or any evidence that there are users out there who care about
> these drivers.

Well, these drivers just work and I don't see why there should be regular
discussions about them or changes.

Adrian

> [1] https://cdimage.debian.org/cdimage/ports/snapshots/2022-12-09/
> [2] https://www.gentoo.org/downloads/

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913


