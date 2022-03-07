Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CF5C433F5
	for <sparclinux@archiver.kernel.org>; Mon,  7 Mar 2022 08:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbiCGI6K (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 7 Mar 2022 03:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236309AbiCGI6J (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 7 Mar 2022 03:58:09 -0500
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Mar 2022 00:57:14 PST
Received: from mail.lasedrum.pl (mail.lasedrum.pl [151.236.17.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034F72019D
        for <sparclinux@vger.kernel.org>; Mon,  7 Mar 2022 00:57:13 -0800 (PST)
Received: by mail.lasedrum.pl (Postfix, from userid 1001)
        id 618D040CD0; Mon,  7 Mar 2022 09:50:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lasedrum.pl; s=mail;
        t=1646643032; bh=jqHIBqxs7o8giDgUN2U2QL98LF/31E7JMwKZLkg2F1M=;
        h=Date:From:To:Subject:From;
        b=PIwd3E2KPRg5X8FZTdWuBv4rDQmePFEoFwrzMNKVzxy1zidfGO7+orhm+J2OM8n/D
         pvfWpVA0euGa9gcgRMnYYR2t/9KSh0xtThiuDYabaYrl4yXwenQYnqN9hik60q0OlS
         PiiZ4Jsa6rXZtSNRXZjGum27PN1innhqHCfxyqB51zT3ngFzI2BdMilKTHuG/M/iMV
         236Hn4Zt+Mf2miSvjWFtptwg3CKUtebuY7C8JOru4n4F92+jW1wzgAKpJoSEj/gE6L
         KDKuW5AM6n3EwlDQs3wZqPcNal+3TF8vzPbcPP5iyvo76i7PKA3oYbgW3dSc67BaoI
         NkhfKIjUtFbbQ==
Received: by mail.lasedrum.pl for <sparclinux@vger.kernel.org>; Mon,  7 Mar 2022 08:50:20 GMT
Message-ID: <20220307084500-0.1.1a.359e.0.x65l3dbqh3@lasedrum.pl>
Date:   Mon,  7 Mar 2022 08:50:20 GMT
From:   "Marcin Chruszcz" <marcin.chruszcz@lasedrum.pl>
To:     <sparclinux@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d?=
X-Mailer: mail.lasedrum.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam,
Marcin Chruszcz
