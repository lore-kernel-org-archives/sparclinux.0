Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F21FEB64DD
	for <sparclinux@archiver.kernel.org>; Thu, 29 Jun 2023 19:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjF2T6N (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 29 Jun 2023 15:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjF2T6G (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 29 Jun 2023 15:58:06 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6592B30F6
        for <sparclinux@vger.kernel.org>; Thu, 29 Jun 2023 12:57:56 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3942c6584f0so755750b6e.3
        for <sparclinux@vger.kernel.org>; Thu, 29 Jun 2023 12:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688068675; x=1690660675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJ/xKxE/4SOUFhnWdePYMrjihUjgQXmu4T3rrVCYJnk=;
        b=O7agXgqg/5EnBzgOf/hyEa3CfJrv+rnuzddn3TNmncxMzxlgkxVF400ns0ScHq8nwO
         miBMky1Ts8sK6piTFjjx4u/zdn8kQOa7aAhFug4K34bwaFXNYZcv7WQ8qnHUTGujQV8e
         hSPUrKYsB1Y3BCOweX0S5GaJzo71OMSbL4EF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688068675; x=1690660675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJ/xKxE/4SOUFhnWdePYMrjihUjgQXmu4T3rrVCYJnk=;
        b=Zum2ISXDZMoNLUwN3JyxN7fU4v8UGzal1RnSwVkLEnHeBfEuIP9nx8oF9uatnM4eha
         8ERomSvOQ+79vvhO+9oe2U6LIMTgldB3atVBQcRQ+jBC/dyUEh/7pEsBGpWXJ4PGeeBg
         nTaATYKjauVkkriC+jWmmAYWt8mCte6tImZDD9pqc8sgeNcqmuIgW9pDENndPE753U1Q
         BHsVScJoPZDhzgAjqJLdkUbgCx2uA+lj861Byh2ZR02cmrefoF5nKiBOFYu/JvF8IMuv
         LdUI2k4p2z0sjhQgoCX9P4O71TeLjVMI0meBckjqLqGiwDpCb5uTnCtT0aSeJGGY4pjr
         pMGQ==
X-Gm-Message-State: AC+VfDxefPVEpnqa6ksx1dBZ6DpWXHf3t8ak7DgQht7GmzxH9+C8h7t1
        uoK3oM01opZzfghgzZUrS/Xx2w==
X-Google-Smtp-Source: ACHHUZ5VfHaZQ1vgYvKEfwSq3bkC/Mv2QGtvfel8EjnRJ3kX52MGrTqrYD9m0XcISsUNgQjjJRV6uQ==
X-Received: by 2002:aca:6707:0:b0:3a3:7eab:28a7 with SMTP id z7-20020aca6707000000b003a37eab28a7mr384557oix.30.1688068675495;
        Thu, 29 Jun 2023 12:57:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 199-20020a6301d0000000b005533a901a5dsm9132408pgb.19.2023.06.29.12.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 12:57:55 -0700 (PDT)
Date:   Thu, 29 Jun 2023 12:57:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] sparc: openpromio: Address -Warray-bounds warning
Message-ID: <202306291257.FF5C86E@keescook>
References: <ZJTV61z4+lsKlzQG@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJTV61z4+lsKlzQG@work>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Thu, Jun 22, 2023 at 05:14:51PM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in struct openpromio.
> 
> Address the following warning found after building (with GCC-13) sparc
> with sparc64_defconfig:
> In function 'opromgetprop',
>     inlined from 'openprom_sunos_ioctl.isra' at drivers/sbus/char/openprom.c:312:11:
> drivers/sbus/char/openprom.c:141:24: warning: array subscript 1 is above array bounds of 'char[1]' [-Warray-bounds=]
>   141 |         op->oprom_array[len] = '\0';
>       |         ~~~~~~~~~~~~~~~^~~~~
> In file included from drivers/sbus/char/openprom.c:31:
> arch/sparc/include/uapi/asm/openpromio.h: In function 'openprom_sunos_ioctl.isra':
> arch/sparc/include/uapi/asm/openpromio.h:16:17: note: while referencing 'oprom_array'
>    16 |         char    oprom_array[1];         /* Holds property names and values. */
>       |                 ^~~~~~~~~~~
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -Warray-bounds.
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/322
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
