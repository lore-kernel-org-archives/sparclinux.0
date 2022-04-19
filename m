Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB556C433EF
	for <sparclinux@archiver.kernel.org>; Tue, 19 Apr 2022 14:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353374AbiDSO14 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 19 Apr 2022 10:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344451AbiDSO1Y (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 19 Apr 2022 10:27:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737DF35A86;
        Tue, 19 Apr 2022 07:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=QRN4/34OFqUjwLHam1sFiw9iJlUmkM8QPvj7xrCnYKs=; b=olpZeZuG5vSaCR29KjZHMIppT6
        FeO8oEu8HcPLPnM2qKvmF8aQVzYcU+VFlUfyEHGZyllGDnfBqN1UtpiMNOqp68KpIqmaUmAe7Y0vd
        wiYSW5g8uQfb8GyQxtQT9Mg8Q3XSi5gfDx7b3qEFPrLWkfmY9F68qIt28bA5/8f9E8IP2BLraSkng
        djkAdiBj7/gNr7y5NHeJvNzx0eHAO8rEI0fvzU41LwqBFO99RTzCPyMLSpm7GHvx9o3OQLVwAsnbu
        llDNy2hAkOJmqF9s5X8kQHX8VY+zpDQCX+mjVRrVv1pq05FDExXUjOnW8nxE7+uTckqMhCztzvlnr
        P+LGj+kw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngomU-003B5N-2j; Tue, 19 Apr 2022 14:24:38 +0000
Message-ID: <f07a0403-0c8a-f099-cb6d-2c53294204ab@infradead.org>
Date:   Tue, 19 Apr 2022 07:24:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Build regressions/improvements in v5.18-rc3
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Cc:     sparclinux@vger.kernel.org
References: <CAHk-=wgBR6P8EseYMjfMjxQ_oTpoQmL0qvKpAw04kP-HBgSGFg@mail.gmail.com>
 <20220419072058.4015664-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2204190925230.302265@ramsan.of.borg>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <alpine.DEB.2.22.394.2204190925230.302265@ramsan.of.borg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org



On 4/19/22 00:26, Geert Uytterhoeven wrote:
> On Tue, 19 Apr 2022, Geert Uytterhoeven wrote:
>> JFYI, when comparing v5.18-rc3[1] to v5.18-rc2[3], the summaries are:
>>  - build errors: +3/-6
> 
>   + /kisskb/src/arch/sparc/include/asm/cacheflush_32.h: error: 'struct page' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]:  => 38:37
> 
> sparc64/sparc-allmodconfig
> sparc64-gcc11/sparc-allmodconfig

I have posted a patch for this one. Don't know when it will be merged.

https://lore.kernel.org/sparclinux/YlIxJWek5a4wB8Jt@gondor.apana.org.au/T/#t


-- 
~Randy
