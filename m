Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50019EB64D7
	for <sparclinux@archiver.kernel.org>; Mon, 19 Jun 2023 00:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjFSAXb (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sun, 18 Jun 2023 20:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFSAXa (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sun, 18 Jun 2023 20:23:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67210E49;
        Sun, 18 Jun 2023 17:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=b7gyHO24N3WZ07GlteZpo9/cfkkPPqpQCtFlsB7cZQM=; b=eq/tnx9Ym8abDv2aEKGZPhZOKF
        whuurQnVCi0VBp1b6k1Ci3RmRlO58LTo0Ws3e9wa2yzRy5gmV4ZJarfaUTvWOhQ8m5p3PclW/+pMY
        LfoOEvBVlRyH/xKt8eMaoxD9ThuAXufIHyTJIU/7XudU/B4YqKK5QjwAz8QS27mYn5GVvD7vxvMWn
        Q42KbCRPvpYiqDHFzxh91YMIDTGhrJpK7jnV/CFfMJjW30h99Lp1sPrt9rEfVkL7KcYhL1gvdMpwj
        7qMvFUhBmhjp0UYuWOPBo0oIeaG1UvzCm5MYBatt1IzggL6k2Kg0aJVUM8yoEaHy7O26tpUR8GNGB
        kMj7h2hA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qB2fy-0071Pa-13;
        Mon, 19 Jun 2023 00:23:22 +0000
Message-ID: <ea8b0e25-fd2e-4fe1-3157-7556e29eee87@infradead.org>
Date:   Sun, 18 Jun 2023 17:23:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] parport_pc: don't allow driver for SPARC32
Content-Language: en-US
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-parport@lists.infradead.org
References: <20230406160548.25721-1-rdunlap@infradead.org>
 <alpine.DEB.2.21.2304062039260.44308@angie.orcam.me.uk>
 <20230406203207.GA1534216@ravnborg.org>
 <alpine.DEB.2.21.2304062144520.44308@angie.orcam.me.uk>
 <20230407200313.GA1655046@ravnborg.org>
 <alpine.DEB.2.21.2304072142290.62619@angie.orcam.me.uk>
 <a05558c3-8d5c-c389-ba4c-be134c75ac1c@infradead.org>
 <alpine.DEB.2.21.2306190000530.14084@angie.orcam.me.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <alpine.DEB.2.21.2306190000530.14084@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi,

On 6/18/23 16:42, Maciej W. Rozycki wrote:
> On Fri, 7 Apr 2023, Randy Dunlap wrote:
> 
>> /me wishes that we had a Sparc maintainer.
> 
>  What happened to DaveM?

I haven't seen him merge any arch/sparc/ patches lately.
I have a couple that are still pending.

>  In any case after a couple of iterations I have made a succesful build of 
> a 32-bit SPARC toolchain now, which I was able to verify a fix with I have 

Is your newly built toolchain for riscv hosting?

> outlined earlier in this thread.  Posted as archived at: 
> <https://lore.kernel.org/r/alpine.DEB.2.21.2306182347101.14084@angie.orcam.me.uk/>.

thanks.
-- 
~Randy
