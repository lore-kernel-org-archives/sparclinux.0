Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DD8E94115
	for <sparclinux@archiver.kernel.org>; Fri,  6 Oct 2023 20:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjJFU07 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 6 Oct 2023 16:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjJFU07 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 6 Oct 2023 16:26:59 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5021EBF
        for <sparclinux@vger.kernel.org>; Fri,  6 Oct 2023 13:26:57 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-53fa455cd94so1829098a12.2
        for <sparclinux@vger.kernel.org>; Fri, 06 Oct 2023 13:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696624017; x=1697228817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ik+8xyOrxrDENzMU2+XdXOoH+BEnHgLDW/RYA7oHq4=;
        b=gD3kK/oSz9HpK1bX6ilsgqMakimaq8cgsY52n1LikFP8Titet9S97kTAwIIa6d7y4F
         1RJWF9rdgeOWQCoB/ft170/3JQTKpCxY8FKvdmNzTXAbASZPDsG2tjd7EtEk2XqpVNZH
         Wix9Eo44RUWCVF5p0lzNn79tIabC7ZQGPe5uU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696624017; x=1697228817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ik+8xyOrxrDENzMU2+XdXOoH+BEnHgLDW/RYA7oHq4=;
        b=sWJZ9U3WKBUvD5oFnaNchO+RluiMbG8/3oDxfteYtXv+yelXWkADEyTwJKMoZjgJbw
         XH21F41vVDTCFZsVzCNqmh9qGhU1PMMgSQLgLy+4zIfaYM2PIY6VvoLV4lPLMBZSYYTm
         1VBaVE0AqnRzT7A2EpRNkAr12m6dLYr3ZBcrG+S4hhxxYhipvny7UmHHypyjWLiaK9xd
         o4YAwsZdVWo+Avf00YlLsTChapjCEW5JedKxj/gYzuasC28rycCcdKQMBbd3wraqMazU
         nuVAsen1I861fDQbQLSb0zvnm2oHqkxyNnfBAeCPix0UGGoxsrdOSkwGqP0ghraKA96j
         B3bw==
X-Gm-Message-State: AOJu0Yw6n89MZe8X3D2Gn7Jr4//EU28PAv9afWIvb1lBoRF61W3DXrmf
        ltnVso8TKZ18/VeaLaGIk07wOA==
X-Google-Smtp-Source: AGHT+IG2uZ4oQ6pqs/gPUxE9hmNLIVY3TcFTdzCBj+5FryP0YVUJaPRylWXG7huLOl6hdWH/tBpVog==
X-Received: by 2002:a05:6a20:3942:b0:14b:8023:33c8 with SMTP id r2-20020a056a20394200b0014b802333c8mr10453505pzg.2.1696624016776;
        Fri, 06 Oct 2023 13:26:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c8-20020aa78c08000000b0069102ae6d93sm1952733pfd.14.2023.10.06.13.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:26:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>
Cc:     sparclinux@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sparc: Annotate struct cpuinfo_tree with __counted_by
Date:   Fri,  6 Oct 2023 13:25:46 -0700
Message-Id: <169662394357.2154428.12028362294967452741.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922175159.work.357-kees@kernel.org>
References: <20230922175159.work.357-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri, 22 Sep 2023 10:52:00 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct cpuinfo_tree.
> 
> [...]

Since this is a trivial change and it's been 2 week without further
discussion, I'll snag this patch.

Applied to for-next/hardening, thanks!

[1/1] sparc: Annotate struct cpuinfo_tree with __counted_by
      https://git.kernel.org/kees/c/cfa36f889f23

Take care,

-- 
Kees Cook

