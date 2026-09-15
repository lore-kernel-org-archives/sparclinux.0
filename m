Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2D2440A25
	for <sparclinux@vger.kernel.org>; Tue, 15 Sep 2026 22:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789510894; cv=pass; b=PArnyVPohnhMkF3zLGCP+ildFYvBRCeqw4I7oXNn4YAvx2Enoq70u4d+Hgxk86zPGhXh9j/GJ+7itl5fyKAK+aaWvTyKb74rSkdMvot4jdCdDzRqW/2jZG2e8tqTKWc6eFJA1eDDsdp5elyK9TXQsvlrgQiIHX0uIIzBL/cvDEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789510894; c=relaxed/simple;
	bh=zMEH3dKvgIFeOLNgenpgNKtSSPQyo3I2Bi4hOFPx7Sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRjEY6GhYqeNtkIuoHAh48h39NdOEHEWD5TdcUWEB6SQs6iGQnyKRjJCkX2jC8ey/BZ2DUVNZdPfq+KfSHDyWbxcncMsv2XSZn+xs2IMlKdEOlZqJM+GuHbrjdt0QfvJmNDRisrzhm0bDexRKKyiEGE6rLJ1tYiJQtUfNk9YGso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IV/k2TQj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aB07AtjI; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IV/k2TQj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aB07AtjI"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLYtax721423
	for <sparclinux@vger.kernel.org>; Tue, 15 Sep 2026 22:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=; b=IV
	/k2TQjkUrsTGpshqW8f1AkLpzgE6WqJLnJXyVNHKYz8mozA+vLQbIOpShvI99Nvk
	BGk11nj45xZQZMebNdo7NiYw/EO7W5wcvHVc8eAkRKtGrNMclkKkbe3unomYvdUd
	vFaT1byqggr1zubtRjDzuTG9pECEQdOzFAiv4kdIU3d7CXM0IsQ27dhrP8NvQBkU
	TlOdMgPnM8h4FF25SXM2n03VFD94RLvjnLlaGSHHxie20ptztZeSDX3B4EelrzMT
	n1DLEJiB1mKEp0dVH3Si7JCiMZpC8ZcIigaByfbQDV2F2ANWVcL1rru5kNRyAlZ9
	ag1DWjYpUlLQQuGalXdA==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqah9s4m6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <sparclinux@vger.kernel.org>; Tue, 15 Sep 2026 22:21:31 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-45e83fd0663so6244508fac.1
        for <sparclinux@vger.kernel.org>; Tue, 15 Sep 2026 15:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789510891; cv=none;
        d=google.com; s=arc-20260327;
        b=EJTt2XMCfvQGAPjfw3msxSp2AHQFW++mAjyD+USSewq+tUe2JZR+Y57o688H3jMdeI
         ZO4UyYZgyTpdotZhniRYydrNg4sINZNzwpYQ5DWm3rfLOxOJFBiMLmBKjJDRE2JEdR9N
         snPlrz7CVZ5AOVVei9PL67mscGrFHGcUFZryfy1hoR8oxH8DlZ8rtlPn1tQkum3CIW4q
         uyCOa02NqR5gwdKHYdcDWyvaloM5j3oQuQtqutH1l2Ar9XiliL8p0tP5pR3RigxNOYci
         NJ2TmcfeD/hkfIB2p+Sw7d8lpaD46ptxc7o+QhP4l81R0UWsKxS+yLrU8voggZASpYxv
         Oa3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        fh=CgWausdUi1YDWn5on/32J2skbBas3qJPp7EwMxsBbuo=;
        b=ZuyDfTne0UmUXdY4s4zFzWGCWaMPksGm7SFNphBQAOnhbinR57TH8Ppv8tm4Zl/zMd
         ngmxN79WKnPEgy3wUFP51N8N2sViOqWp75+kW+SQGdhuylCCRcUfJkXkav6FIj+nOowA
         oZ9GvceGk843adF1OUpY+CLhQXlqK+vWTch3XAw5qeV4RPkPaYQxUlp3LYEHfDLG0xO/
         GBUtjS67ZXYSPFXVvsRVvcsVf5ufu8qT4YN+ZRpBy4/iYAFXgEIF8jVTH/P1BTvgPu2h
         kPa+fNWr7MWzjFdjaKtuObwy/8RnxPaLvhKiZEgPjoe0XO8CV3NBixQDx6QHykd5K8ar
         S/cQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789510891; x=1790115691; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        b=aB07AtjIKjPYRGcvBSuVUhbZlxd1+55zy/NhIuvnz19m7qssQTpE/4jhghs82a98Dx
         rtzGuCLITyYJpv6qqsfwRyWf2V/rvp/BavfnHKk+3jeYdHSZJCYDfk5x4efzm884vIfW
         UjGKSA8ySqC+bc1butY/HkkuCwEw+HH62Uipjk8j8bjqvTXRubAdUvP+c5BJvALTKQeE
         2MFV1Wjr7h5QJcQaotkuVTv077nzlClUSJUJjEEq6X2ukv02bdE+qejZx/+uCM7gRcPt
         xEQKVpHKyQ6abdYF/Q1vdcAj2ZFa315JGdv0g44dh8zUZEwY87qYbRStthdyfxwDukm3
         Mbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789510891; x=1790115691;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        b=Q7jwovNv0+zI7YoB7o0m79PvY+FB8JHNrLe4h0DMju/HIiXNGKIcpvCw8+YH5uSavG
         zUhr8MY2gC/3mJEeup0PnCDfT9RBdW/9+90UfU5fEdgSv0dNrtSLOTfrWq/jCsqw2Nmv
         cD0MqxfsC4JzvMtmNReL+lTAgQ8uKl6WJbw26X7grXK1ycN8Sxi6tiCmJr+1oP0vgrKD
         4aBL7JhIutW9+CuMTITIwfI41vks8j62l2ExAel/K4bz6iEUFLpLg0W0b/1GaJHzXi+o
         tS4yORXV0cJy9Lu3YLsGEqI3T4HD3Ea6geqrLNOAzPA3ASXHZ6EejsVzVR0MXQr7fGKB
         9ghg==
X-Forwarded-Encrypted: i=1; AKwUvBxhgZX53IBm/XZDN0L5hjeJAgxhwSADan3v3fafv0ClyVVAkPdqhO13mMD/CzBIRWsLJV2357paUKL8@vger.kernel.org
X-Gm-Message-State: AFuF++lpatBq1svhCTkWLJ24tWJdODuFWhc/iqhXr1oRH9yU7TPGCMZL
	X4ybe0qKW+tP0R16mclEeWHNA4JOkEFr9+tiG7z3bDOdl2Lm5fvHRmaWIjqMnIy/uEJ6thH42hz
	zOuab41hGfYQDqSF+uxcnWy6eeT/fnNqkALnju8DYzKiwuxps0BQ969GrfuQVjwiHc2R+HMFoav
	7rwyyqzXvLBEZxKr3RMXlKOQIsKt+zSOkT5Fkjp/0=
X-Gm-Gg: AYBFou2lOWWkIrLCF37IViPrQZhdSYmMm8RMJR5h3f75GjvZLw0XtSuiUk1rudSrqOh
	+6noZiCCdjvo9xDXsph7LRVMy28w3oVkhOwpsoMERNCuQcABsajgIzHwG6gp2GUfrx6nei5gy97
	MqTGWspa0Xqa7FPLXEEOO1qZ7c4J6waGPuvuCYu7vxSQKXHvQcDr1fuZNc
X-Received: by 2002:a05:6870:30f:b0:45e:2de4:95f1 with SMTP id 586e51a60fabf-4847584c51dmr189766fac.2.1789510890858;
        Tue, 15 Sep 2026 15:21:30 -0700 (PDT)
X-Received: by 2002:a05:6870:30f:b0:45e:2de4:95f1 with SMTP id
 586e51a60fabf-4847584c51dmr189724fac.2.1789510890430; Tue, 15 Sep 2026
 15:21:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
In-Reply-To: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 15:21:18 -0700
X-Gm-Features: AcwNN1UxxSxAxz0XPK7niSod0Tx_HsUs-C3mKdcqDSaFkh659BGkCorPygYZGHE
Message-ID: <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, bpf@vger.kernel.org,
        David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev,
        kvm@vger.kernel.org, kexec@lists.infradead.org,
        linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=BtkIUoX5 c=1 sm=1 tr=0 ts=6aa9c4eb cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8
 a=2Rxv5svHm-zNKBYa0PsA:9 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22
 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-ORIG-GUID: zwGrnYwRqVGpu4RmEs7HsLUw5WPPiHPP
X-Proofpoint-GUID: zwGrnYwRqVGpu4RmEs7HsLUw5WPPiHPP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDMyNiBTYWx0ZWRfXy5s6yoEjaEbL
 YqB61wCB6vJlfeM3rxQ9Lu7hR+wel1fQWuj8XYqH1yg4xiJweeY4CabogU8wB53gPNBmUCID6pw
 HTQQRDaTc+Zwkpdvmkdi+gBFEDMGx9L+lua/LJxGSvFGK++ScSZZ06aiuRaPJCH3KzvuN2zf8uC
 ZD+KwpkKUeXVYfE9qjz9owbQT3TrNIYMlzM/fZvc/R9tcKw4YqflXU3LKK9yrQIVNq3gkmeIMa3
 51YY2fKU5z/zi3NNCQYHQuqRLW/aIsApGr2KPZrKfaoFzAmJlw8uooyeOqM5vCFTr/jvFr2wzAo
 PISM95jkoyeqkYVgZEeGbY2koiJfU/dyZX/gn953nGMw6BNA4L4dCgo3se67wL+CsUaNJZokQ2T
 Ci/ToyHsG42Aw8OT4urWsPKas4FMklE1aZJwn2MO7nsEJCDX36VTowQF2TuYCxfIyzg2M4XXcW9
 8haLXLTGvRysgfov1GA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDMyNiBTYWx0ZWRfX+5w8mBdXZV3q
 7qkIjs3uSorWtRLap+0boN0rtQkIEDxNEL9TLE3pAwkkk/F/H9SXFfcWay/Dhyyi3mEZAjZO0sL
 N//UYmwSCIgRHyQaSESrxsOUdm2kIG8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 clxscore=1011 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150326

On Tue, Sep 15, 2026 at 9:02=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 15 Sept 2026 at 04:31, Christian Brauner <brauner@kernel.org> wro=
te:
> >
> > TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> > allocates a descriptor like get_unused_fd_flags() does and records it i=
n
> > a slot on the task. fd_stage() attaches the file to that slot and
> > returns the number.
>
> Honestly, I am *not* a fan. At all.
>
> I think this adds complexity rather than removing it.
>
> The diffstat tells a story:
>
> >  106 files changed, 962 insertions(+), 861 deletions(-)
>
> in how this adds a hundred lines more than it deletes.
>
> But to make things worse, it adds them in bad places: low-level
> architecture assembly code.
>
> Those extra lines are *not* making complicated code simpler. Quite the
> reverse. They are taking fairly straightforward "just deal with errors
> with normal cleanup in the place where it makes sense" and makes the
> *straightforward* case simpler, while making the big picture more
> complicated and subtle, and adding new code to places that are not
> simple and just blindly do somethign that makes no sense in that
> context.

With fd's it is more than just about error rollback.. exposing an fd
to userspace mid-way thru an ioctl is an easy security bug to write..

OTOH, "just use FD_PREPARE() / fd_publish()"..

BR,
-R
