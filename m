Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D645C0015E
	for <sparclinux@archiver.kernel.org>; Wed, 19 Jul 2023 14:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjGSOkF (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 19 Jul 2023 10:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGSOkE (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 19 Jul 2023 10:40:04 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CD8C7
        for <sparclinux@vger.kernel.org>; Wed, 19 Jul 2023 07:39:56 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 311E35C0185;
        Wed, 19 Jul 2023 10:39:54 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 19 Jul 2023 10:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1689777594; x=1689863994; bh=nZU6p3n7fickF5wKWXmSN8Sc6/MSvsFTYGP
        0irgDDx8=; b=lFbQ3Fpz9mnP0DhOx0jacQU6mRyVVmb9HOWMaoFF9MJTo709FOH
        eo1D4685e/yyJVfMIkbe/qsDDpFeWNtjWGWyfVujY0N17u82hoBjymlSEsGmmSUu
        B+fkecDd0jS7vl39Keu7GlY/K6pnNmTXPf6MZ0qeVs+NqNuEb7UfuDOtHM0HA7V3
        cM5eSPRishoC8Tvv/nRNgNMKuqk1QCT3m1Gv0lvGf/xHA1LWn7bsvUeFG7SUdzPR
        P1ngK5UuVfELsnJtrPFqgl7AfErdRAGePzxdZRnFBJre0tbgbisjNmOFzSA43525
        qYdmXtUboYHkaXJ6Fkl/1uau2nz1fS46Ebg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1689777594; x=1689863994; bh=nZU6p3n7fickF5wKWXmSN8Sc6/MSvsFTYGP
        0irgDDx8=; b=YKg9ECVCNv4jhOGOcXmtShJrCMpSZRIZldv95wfAELAqIKUm1cn
        WzZwptD0/MpQKKYr4uJBk4jxsypyHaQlPOuZUMhYf0Fd5IXeDr9fl22N1KBKqLWi
        dxCQSf8bJDKvQ/QsSAo0eXwOQhlDhoBrDeeZfjZSnoDO0oIR2BkYnUvjpEP4OG06
        TZVxTxDFpBJt6xX0fYydWiWuG/+HZMLzTPg8dmYyBmpK/8GTzr9jmrWbeBix0w3W
        Ef5IHFidrHDMYBXjA4ae7ScdI/979EM+XAVafaSY6Ymr4aCvAQo3oPS+qkviKCx9
        ke1X54uqKSeFsENCqqBnVOOaBIs10+VtM1Q==
X-ME-Sender: <xms:ufW3ZOXi-4KgUS7ALB6HOiKSWBXHzSCcx-uVus2GGIal7ZW38uYjFQ>
    <xme:ufW3ZKl1KxwafCDpsoJd7rQ7NMTSUdpfquRUckOXNGPK8fjcWnz6zm3uWQ2Ar4m5p
    -nKkLqFLP5ccJ5H98A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgeekgdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ufW3ZCZHYwcevjo8AQAezWBV8MiAxgub21UGdh3YR3Un6iTi988W4Q>
    <xmx:ufW3ZFXbHCcyL74qyiGP7HPc7hMwxJEqJKtNooPyHeLV0qTXwnqZNA>
    <xmx:ufW3ZImF97gpX7AQDpCfLGTizFgV-f33ssWgu6O9zYc3zATTxfQAAg>
    <xmx:uvW3ZKRU3wdXZrs_3a-yj2msIlAsfeY6IP9GND0pPpgDYqdtHKPkGw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8026EB60086; Wed, 19 Jul 2023 10:39:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <3b047cd4-a61f-44b6-830b-b4e35bfccd72@app.fastmail.com>
In-Reply-To: <32595080-dd79-5cf0-46e7-b82d0df8f067@linaro.org>
References: <20230719123944.3438363-1-arnd@kernel.org>
 <20230719123944.3438363-6-arnd@kernel.org>
 <32595080-dd79-5cf0-46e7-b82d0df8f067@linaro.org>
Date:   Wed, 19 Jul 2023 16:38:57 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        "Arnd Bergmann" <arnd@kernel.org>, linux-fbdev@vger.kernel.org,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Helge Deller" <deller@gmx.de>,
        "Javier Martinez Canillas" <javierm@redhat.com>
Cc:     linux-hyperv@vger.kernel.org, x86@kernel.org,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org,
        "Max Filippov" <jcmvbkbc@gmail.com>,
        "Will Deacon" <will@kernel.org>, linux-efi@vger.kernel.org,
        guoren <guoren@kernel.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org,
        "WANG Xuerui" <kernel@xen0n.name>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Dave Airlie" <airlied@gmail.com>,
        "Ard Biesheuvel" <ardb@kernel.org>, "Wei Liu" <wei.liu@kernel.org>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Dexuan Cui" <decui@microsoft.com>,
        "Russell King" <linux@armlinux.org.uk>,
        "Deepak Rawat" <drawat.floss@gmail.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Matt Turner" <mattst88@gmail.com>,
        "Haiyang Zhang" <haiyangz@microsoft.com>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Borislav Petkov" <bp@alien8.de>, loongarch@lists.linux.dev,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        "Khalid Aziz" <khalid@gonehiking.org>,
        "Brian Cain" <bcain@quicinc.com>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, "Dinh Nguyen" <dinguyen@kernel.org>,
        linux-riscv@lists.infradead.org,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Daniel Vetter" <daniel@ffwll.ch>, linux-alpha@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 5/9] vgacon: remove screen_info dependency
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Wed, Jul 19, 2023, at 15:49, Philippe Mathieu-Daud=C3=A9 wrote:
> On 19/7/23 14:39, Arnd Bergmann wrote:

>> @@ -1074,13 +1077,13 @@ static int vgacon_resize(struct vc_data *c, u=
nsigned int width,
>>   		 * Ho ho!  Someone (svgatextmode, eh?) may have reprogrammed
>>   		 * the video mode!  Set the new defaults then and go away.
>>   		 */
>> -		screen_info.orig_video_cols =3D width;
>> -		screen_info.orig_video_lines =3D height;
>> +		vga_si->orig_video_cols =3D width;
>> +		vga_si->orig_video_lines =3D height;
>>   		vga_default_font_height =3D c->vc_cell_height;
>>   		return 0;
>>   	}
>> -	if (width % 2 || width > screen_info.orig_video_cols ||
>> -	    height > (screen_info.orig_video_lines * vga_default_font_heigh=
t)/
>> +	if (width % 2 || width > vga_si->orig_video_cols ||
>> +	    height > (vga_si->orig_video_lines * vga_default_font_height)/
>>   	    c->vc_cell_height)
>>   		return -EINVAL;
>>  =20
>> @@ -1110,8 +1113,8 @@ static void vgacon_save_screen(struct vc_data *=
c)
>>   		 * console initialization routines.
>>   		 */
>>   		vga_bootup_console =3D 1;
>> -		c->state.x =3D screen_info.orig_x;
>> -		c->state.y =3D screen_info.orig_y;
>> +		c->state.x =3D vga_si->orig_x;
>> +		c->state.y =3D vga_si->orig_y;
>
> Not really my area, so bare with me if this is obviously not
> possible :) If using DUMMY_CONSOLE, can we trigger a save_screen
> / resize? If so, we'd reach here with vga_si=3DNULL.
>

I think it cannot happen because the only way that anything calls
into vgacon.c is through the "conswitchp =3D &vga_con;" that now happens
at the same time as the "vga_si =3D &screen_info;". It's definitely
possible that I'm missing something as well here.

     Arnd
