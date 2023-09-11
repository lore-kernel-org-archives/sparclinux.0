Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECEFEE57DF
	for <sparclinux@archiver.kernel.org>; Mon, 11 Sep 2023 07:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbjIKHTp (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 11 Sep 2023 03:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjIKHTo (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 11 Sep 2023 03:19:44 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EC1CCD;
        Mon, 11 Sep 2023 00:19:40 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2bd0bc8b429so70713981fa.2;
        Mon, 11 Sep 2023 00:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694416778; x=1695021578;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1w0gJ8VucCHkHZWoua7Qc/5PiCQ3+s3Mo+G7A+1yBko=;
        b=XqaMtMxFfpP77efcgIONMekJdeBTx30O7YbJCVf2+o1B9Ebyjj0FxGGlHifuBwdxsf
         5ddYtxB/0nKkBnu6VL923Q21T4DdcQlJWfjRzo30sSHGk2f6/0IE+O6GhZFyb/PkpOMy
         yNAQtqt0mgyu+jMPM+PcU/w3LKKzcbk6URmK+Ax92UdHNtM0uvKj617GdlHEnJIiIxey
         aTEDB1GNT8hYTvuO4B8PxeWMRAwV9U088y2Hj2HznpYDuoxCCZtStnmQ/Tcfn7YGx5HT
         PzYSMe9kksw3Tszez8rIizP/WHjnBYz9xtz0K4cmR9vwrwKKeOCdslp+/Gujit2AgJ9w
         eiIQ==
X-Gm-Message-State: AOJu0Yx4kkrWIBnusxmtKVwyla74C/oRSk1MyXK8yvK3udFBC8bgLjLx
        iM7jlc6GG+lShOVt52jW0CA=
X-Google-Smtp-Source: AGHT+IG9P0MTaC4ckPPaRL6/2+85VnbCZDw/Zz3yf1mUw+I6J+WVFbgybwigAXq6J3GZM1U9eX1xSg==
X-Received: by 2002:a2e:8510:0:b0:2b6:da1e:d063 with SMTP id j16-20020a2e8510000000b002b6da1ed063mr6928027lji.45.1694416778392;
        Mon, 11 Sep 2023 00:19:38 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id r20-20020a170906c29400b0099d798a6bb5sm4833970ejz.67.2023.09.11.00.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 00:19:37 -0700 (PDT)
Message-ID: <e7730b24-a38b-22ff-12cb-6d08fdb07955@kernel.org>
Date:   Mon, 11 Sep 2023 09:19:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V2] tty: vcc: Add check for kstrdup() in vcc_probe()
Content-Language: en-US
To:     Yi Yang <yiyang13@huawei.com>, davem@davemloft.net,
        gregkh@linuxfoundation.org, jag.raman@oracle.com
Cc:     sparclinux@vger.kernel.org, linux-serial@vger.kernel.org
References: <20230904035220.48164-1-yiyang13@huawei.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230904035220.48164-1-yiyang13@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 04. 09. 23, 5:52, Yi Yang wrote:
> Add check for the return value of kstrdup() and return the error, if it
> fails in order to avoid NULL pointer dereference.
> 
> Fixes: 5d171050e28f ("sparc64: vcc: Enable VCC port probe and removal")
> Signed-off-by: Yi Yang <yiyang13@huawei.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>


-- 
js
suse labs

