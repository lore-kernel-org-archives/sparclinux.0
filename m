Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DA0C77B73
	for <sparclinux@archiver.kernel.org>; Tue, 30 May 2023 23:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjE3XV1 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 30 May 2023 19:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbjE3XVP (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 30 May 2023 19:21:15 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1491618B
        for <sparclinux@vger.kernel.org>; Tue, 30 May 2023 16:21:06 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64d57cd373fso249134b3a.1
        for <sparclinux@vger.kernel.org>; Tue, 30 May 2023 16:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488865; x=1688080865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ljljFYrI9j90T96SUu8HKEzV53F0QD906Y79Nui+Mxk=;
        b=V6TNfBdP2n2BwA8y8Za2WqcyGJgtgxNpLpZmkOvvEuzyhLnuI3dAzTEPb3/YB/4FUo
         N1trzFO72irFDZ9qOssEHn+eicEFQFPo9qtiIO/2LwmPwIScvQJiOWjfXX0wP81gUzMK
         0iimHJac+WyZS3y8G6a1tuIwZfXNtVlBAZm+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488865; x=1688080865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljljFYrI9j90T96SUu8HKEzV53F0QD906Y79Nui+Mxk=;
        b=djYM6ToOkDZ/5wcmVuZzMI4n3VVxpi5e0IMgsKgwcSDAeVRnaW//Gad2WbvYPN63J1
         D8l5S+fhnBaqusLwleQO3/Z42399KEyJremsMg23X0oEj2uM+S7Y0yD8E9d7D5QEbhfS
         wOKw001Dt4ExOdAtsoxvo4BdqpTY89sT2NgsY+sQtTRz7O8asiqysWOI2UHQKL5R17BZ
         k5H6hAPO8NxAgiG7Vc9p0cbKnOdSZYrhnH733LxmXfk4opQYV3JUdNeAKdmCU6zGEMxp
         bnBn5D1toyFOtfHnZgxFqWI0cKfpMaM6h2ZZG/lkggmJ5Igt3ViIWlYwSjazM1DB1C0A
         mTYw==
X-Gm-Message-State: AC+VfDwAP9XAsQZ1VInYiG0FIXmhTrWDaZFOS0hncHuRuiSfR53WPuZT
        AnDB5nOCm3ej9XhRtar/Uw1Mxw==
X-Google-Smtp-Source: ACHHUZ6xiNFeo5o/L25vvvqopT3t7JyxdHwIM1PpkhrHKD9JuPWUxyfvbMrXvUn38HWPjPPXTxo+aQ==
X-Received: by 2002:a05:6a20:3d84:b0:10d:515:ff2d with SMTP id s4-20020a056a203d8400b0010d0515ff2dmr13086359pzi.4.1685488865544;
        Tue, 30 May 2023 16:21:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s3-20020a63ff43000000b0053b92b26412sm9050237pgk.14.2023.05.30.16.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:21:05 -0700 (PDT)
Date:   Tue, 30 May 2023 16:21:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-hardening@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc64: Replace all non-returning strlcpy with strscpy
Message-ID: <202305301621.87C228E@keescook>
References: <20230530163001.985256-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530163001.985256-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, May 30, 2023 at 04:30:01PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
