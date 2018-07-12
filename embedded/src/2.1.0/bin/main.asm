
bin/main.elf:     file format elf32-littlearm


Disassembly of section .text:

08000188 <m_abs>:
 8000188:	ee07 0a90 	vmov	s15, r0
 800018c:	eef5 7ac0 	vcmpe.f32	s15, #0.0
 8000190:	eef1 fa10 	vmrs	APSR_nzcv, fpscr
 8000194:	bf48      	it	mi
 8000196:	eef1 7a67 	vnegmi.f32	s15, s15
 800019a:	ee17 0a90 	vmov	r0, s15
 800019e:	4770      	bx	lr

080001a0 <m_min>:
 80001a0:	ee07 0a10 	vmov	s14, r0
 80001a4:	ee07 1a90 	vmov	s15, r1
 80001a8:	eeb4 7ae7 	vcmpe.f32	s14, s15
 80001ac:	eef1 fa10 	vmrs	APSR_nzcv, fpscr
 80001b0:	bf54      	ite	pl
 80001b2:	ee17 0a90 	vmovpl	r0, s15
 80001b6:	ee17 0a10 	vmovmi	r0, s14
 80001ba:	4770      	bx	lr

080001bc <getBatteryVoltage>:
 80001bc:	b510      	push	{r4, lr}
 80001be:	4604      	mov	r4, r0
 80001c0:	2001      	movs	r0, #1
 80001c2:	f002 f83d 	bl	8002240 <adc_read>
 80001c6:	f641 13c8 	movw	r3, #6600	; 0x19c8
 80001ca:	4358      	muls	r0, r3
 80001cc:	eb04 3010 	add.w	r0, r4, r0, lsr #12
 80001d0:	bd10      	pop	{r4, pc}

080001d2 <read_i2c_adc>:
 80001d2:	b538      	push	{r3, r4, r5, lr}
 80001d4:	f002 fcbc 	bl	8002b50 <i2cStart>
 80001d8:	209b      	movs	r0, #155	; 0x9b
 80001da:	f002 fcd7 	bl	8002b8c <i2cWrite>
 80001de:	2801      	cmp	r0, #1
 80001e0:	d10d      	bne.n	80001fe <read_i2c_adc+0x2c>
 80001e2:	f002 fcfb 	bl	8002bdc <i2cRead>
 80001e6:	4605      	mov	r5, r0
 80001e8:	2000      	movs	r0, #0
 80001ea:	f002 fcf7 	bl	8002bdc <i2cRead>
 80001ee:	4604      	mov	r4, r0
 80001f0:	f002 fcbd 	bl	8002b6e <i2cStop>
 80001f4:	f3c4 0087 	ubfx	r0, r4, #2, #8
 80001f8:	ea40 1085 	orr.w	r0, r0, r5, lsl #6
 80001fc:	bd38      	pop	{r3, r4, r5, pc}
 80001fe:	f002 fcb6 	bl	8002b6e <i2cStop>
 8000202:	f04f 30ff 	mov.w	r0, #4294967295	; 0xffffffff
 8000206:	bd38      	pop	{r3, r4, r5, pc}

08000208 <getChargingVoltage>:
 8000208:	b508      	push	{r3, lr}
 800020a:	f7ff ffe2 	bl	80001d2 <read_i2c_adc>
 800020e:	1c43      	adds	r3, r0, #1
 8000210:	bf1f      	itttt	ne
 8000212:	f640 43e4 	movwne	r3, #3300	; 0xce4
 8000216:	4358      	mulne	r0, r3
 8000218:	0a80      	lsrne	r0, r0, #10
 800021a:	0040      	lslne	r0, r0, #1
 800021c:	bd08      	pop	{r3, pc}

0800021e <rgb_i2c_delay>:
 800021e:	bf00      	nop
 8000220:	4770      	bx	lr

08000222 <RGBSetLowSDA>:
 8000222:	b513      	push	{r0, r1, r4, lr}
 8000224:	2301      	movs	r3, #1
 8000226:	2203      	movs	r2, #3
 8000228:	24f0      	movs	r4, #240	; 0xf0
 800022a:	f88d 3004 	strb.w	r3, [sp, #4]
 800022e:	f88d 3006 	strb.w	r3, [sp, #6]
 8000232:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 8000236:	2300      	movs	r3, #0
 8000238:	4669      	mov	r1, sp
 800023a:	f88d 2005 	strb.w	r2, [sp, #5]
 800023e:	f88d 3007 	strb.w	r3, [sp, #7]
 8000242:	9400      	str	r4, [sp, #0]
 8000244:	f002 fba8 	bl	8002998 <GPIO_Init>
 8000248:	f04f 4390 	mov.w	r3, #1207959552	; 0x48000000
 800024c:	851c      	strh	r4, [r3, #40]	; 0x28
 800024e:	f7ff ffe6 	bl	800021e <rgb_i2c_delay>
 8000252:	b002      	add	sp, #8
 8000254:	bd10      	pop	{r4, pc}

08000256 <RGBSetHighSDA>:
 8000256:	b513      	push	{r0, r1, r4, lr}
 8000258:	2300      	movs	r3, #0
 800025a:	2203      	movs	r2, #3
 800025c:	24f0      	movs	r4, #240	; 0xf0
 800025e:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 8000262:	4669      	mov	r1, sp
 8000264:	f88d 3004 	strb.w	r3, [sp, #4]
 8000268:	f88d 2005 	strb.w	r2, [sp, #5]
 800026c:	f88d 3007 	strb.w	r3, [sp, #7]
 8000270:	9400      	str	r4, [sp, #0]
 8000272:	f002 fb91 	bl	8002998 <GPIO_Init>
 8000276:	f04f 4390 	mov.w	r3, #1207959552	; 0x48000000
 800027a:	619c      	str	r4, [r3, #24]
 800027c:	f7ff ffcf 	bl	800021e <rgb_i2c_delay>
 8000280:	b002      	add	sp, #8
 8000282:	bd10      	pop	{r4, pc}

08000284 <RGBSetLowSCL>:
 8000284:	4b02      	ldr	r3, [pc, #8]	; (8000290 <RGBSetLowSCL+0xc>)
 8000286:	f44f 5200 	mov.w	r2, #8192	; 0x2000
 800028a:	851a      	strh	r2, [r3, #40]	; 0x28
 800028c:	f7ff bfc7 	b.w	800021e <rgb_i2c_delay>
 8000290:	48000800 	.word	0x48000800

08000294 <RGBSetHighSCL>:
 8000294:	4b02      	ldr	r3, [pc, #8]	; (80002a0 <RGBSetHighSCL+0xc>)
 8000296:	f44f 5200 	mov.w	r2, #8192	; 0x2000
 800029a:	619a      	str	r2, [r3, #24]
 800029c:	f7ff bfbf 	b.w	800021e <rgb_i2c_delay>
 80002a0:	48000800 	.word	0x48000800

080002a4 <rgb_i2c_init>:
 80002a4:	b573      	push	{r0, r1, r4, r5, r6, lr}
 80002a6:	f44f 5300 	mov.w	r3, #8192	; 0x2000
 80002aa:	2400      	movs	r4, #0
 80002ac:	9300      	str	r3, [sp, #0]
 80002ae:	2603      	movs	r6, #3
 80002b0:	2301      	movs	r3, #1
 80002b2:	4669      	mov	r1, sp
 80002b4:	4812      	ldr	r0, [pc, #72]	; (8000300 <rgb_i2c_init+0x5c>)
 80002b6:	f88d 3004 	strb.w	r3, [sp, #4]
 80002ba:	25f0      	movs	r5, #240	; 0xf0
 80002bc:	f88d 6005 	strb.w	r6, [sp, #5]
 80002c0:	f88d 4006 	strb.w	r4, [sp, #6]
 80002c4:	f88d 4007 	strb.w	r4, [sp, #7]
 80002c8:	f002 fb66 	bl	8002998 <GPIO_Init>
 80002cc:	4669      	mov	r1, sp
 80002ce:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 80002d2:	9500      	str	r5, [sp, #0]
 80002d4:	f88d 4004 	strb.w	r4, [sp, #4]
 80002d8:	f88d 6005 	strb.w	r6, [sp, #5]
 80002dc:	f88d 4007 	strb.w	r4, [sp, #7]
 80002e0:	f002 fb5a 	bl	8002998 <GPIO_Init>
 80002e4:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 80002e8:	4629      	mov	r1, r5
 80002ea:	f002 fb97 	bl	8002a1c <GPIO_SetBits>
 80002ee:	f7ff ffd1 	bl	8000294 <RGBSetHighSCL>
 80002f2:	f7ff ff96 	bl	8000222 <RGBSetLowSDA>
 80002f6:	f7ff ffae 	bl	8000256 <RGBSetHighSDA>
 80002fa:	b002      	add	sp, #8
 80002fc:	bd70      	pop	{r4, r5, r6, pc}
 80002fe:	bf00      	nop
 8000300:	48000800 	.word	0x48000800

08000304 <rgb_i2cStart>:
 8000304:	b508      	push	{r3, lr}
 8000306:	f7ff ffc5 	bl	8000294 <RGBSetHighSCL>
 800030a:	f7ff ffa4 	bl	8000256 <RGBSetHighSDA>
 800030e:	f7ff ffc1 	bl	8000294 <RGBSetHighSCL>
 8000312:	f7ff ff86 	bl	8000222 <RGBSetLowSDA>
 8000316:	f7ff ffb5 	bl	8000284 <RGBSetLowSCL>
 800031a:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 800031e:	f7ff bf9a 	b.w	8000256 <RGBSetHighSDA>

08000322 <rgb_i2cStop>:
 8000322:	b508      	push	{r3, lr}
 8000324:	f7ff ffae 	bl	8000284 <RGBSetLowSCL>
 8000328:	f7ff ff7b 	bl	8000222 <RGBSetLowSDA>
 800032c:	f7ff ffb2 	bl	8000294 <RGBSetHighSCL>
 8000330:	f7ff ff77 	bl	8000222 <RGBSetLowSDA>
 8000334:	f7ff ffae 	bl	8000294 <RGBSetHighSCL>
 8000338:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 800033c:	f7ff bf8b 	b.w	8000256 <RGBSetHighSDA>

08000340 <rgb_i2cWrite>:
 8000340:	b538      	push	{r3, r4, r5, lr}
 8000342:	4605      	mov	r5, r0
 8000344:	2408      	movs	r4, #8
 8000346:	f7ff ff9d 	bl	8000284 <RGBSetLowSCL>
 800034a:	062b      	lsls	r3, r5, #24
 800034c:	d502      	bpl.n	8000354 <rgb_i2cWrite+0x14>
 800034e:	f7ff ff82 	bl	8000256 <RGBSetHighSDA>
 8000352:	e001      	b.n	8000358 <rgb_i2cWrite+0x18>
 8000354:	f7ff ff65 	bl	8000222 <RGBSetLowSDA>
 8000358:	3c01      	subs	r4, #1
 800035a:	f7ff ff9b 	bl	8000294 <RGBSetHighSCL>
 800035e:	006d      	lsls	r5, r5, #1
 8000360:	f014 04ff 	ands.w	r4, r4, #255	; 0xff
 8000364:	b2ed      	uxtb	r5, r5
 8000366:	d1ee      	bne.n	8000346 <rgb_i2cWrite+0x6>
 8000368:	f7ff ff8c 	bl	8000284 <RGBSetLowSCL>
 800036c:	f7ff ff73 	bl	8000256 <RGBSetHighSDA>
 8000370:	f7ff ff90 	bl	8000294 <RGBSetHighSCL>
 8000374:	f7ff ff86 	bl	8000284 <RGBSetLowSCL>
 8000378:	e8bd 4038 	ldmia.w	sp!, {r3, r4, r5, lr}
 800037c:	f7ff bf4f 	b.w	800021e <rgb_i2c_delay>

08000380 <rgb_i2cRead>:
 8000380:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
 8000382:	2300      	movs	r3, #0
 8000384:	700b      	strb	r3, [r1, #0]
 8000386:	704b      	strb	r3, [r1, #1]
 8000388:	708b      	strb	r3, [r1, #2]
 800038a:	70cb      	strb	r3, [r1, #3]
 800038c:	4606      	mov	r6, r0
 800038e:	460c      	mov	r4, r1
 8000390:	1ccf      	adds	r7, r1, #3
 8000392:	f7ff ff77 	bl	8000284 <RGBSetLowSCL>
 8000396:	f7ff ff5e 	bl	8000256 <RGBSetHighSDA>
 800039a:	2508      	movs	r5, #8
 800039c:	1e63      	subs	r3, r4, #1
 800039e:	f813 2f01 	ldrb.w	r2, [r3, #1]!
 80003a2:	0052      	lsls	r2, r2, #1
 80003a4:	42bb      	cmp	r3, r7
 80003a6:	701a      	strb	r2, [r3, #0]
 80003a8:	d1f9      	bne.n	800039e <rgb_i2cRead+0x1e>
 80003aa:	f7ff ff73 	bl	8000294 <RGBSetHighSCL>
 80003ae:	f04f 4390 	mov.w	r3, #1207959552	; 0x48000000
 80003b2:	8a1b      	ldrh	r3, [r3, #16]
 80003b4:	b29b      	uxth	r3, r3
 80003b6:	06d8      	lsls	r0, r3, #27
 80003b8:	bf42      	ittt	mi
 80003ba:	7822      	ldrbmi	r2, [r4, #0]
 80003bc:	f042 0201 	orrmi.w	r2, r2, #1
 80003c0:	7022      	strbmi	r2, [r4, #0]
 80003c2:	0699      	lsls	r1, r3, #26
 80003c4:	bf42      	ittt	mi
 80003c6:	7862      	ldrbmi	r2, [r4, #1]
 80003c8:	f042 0201 	orrmi.w	r2, r2, #1
 80003cc:	7062      	strbmi	r2, [r4, #1]
 80003ce:	065a      	lsls	r2, r3, #25
 80003d0:	bf42      	ittt	mi
 80003d2:	78a2      	ldrbmi	r2, [r4, #2]
 80003d4:	f042 0201 	orrmi.w	r2, r2, #1
 80003d8:	70a2      	strbmi	r2, [r4, #2]
 80003da:	061b      	lsls	r3, r3, #24
 80003dc:	bf42      	ittt	mi
 80003de:	78e3      	ldrbmi	r3, [r4, #3]
 80003e0:	f043 0301 	orrmi.w	r3, r3, #1
 80003e4:	70e3      	strbmi	r3, [r4, #3]
 80003e6:	f7ff ff4d 	bl	8000284 <RGBSetLowSCL>
 80003ea:	3d01      	subs	r5, #1
 80003ec:	d1d6      	bne.n	800039c <rgb_i2cRead+0x1c>
 80003ee:	b10e      	cbz	r6, 80003f4 <rgb_i2cRead+0x74>
 80003f0:	f7ff ff17 	bl	8000222 <RGBSetLowSDA>
 80003f4:	f7ff ff4e 	bl	8000294 <RGBSetHighSCL>
 80003f8:	f7ff ff44 	bl	8000284 <RGBSetLowSCL>
 80003fc:	e8bd 40f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, lr}
 8000400:	f7ff bf0d 	b.w	800021e <rgb_i2c_delay>

08000404 <rgb_i2c_write_reg>:
 8000404:	b570      	push	{r4, r5, r6, lr}
 8000406:	4606      	mov	r6, r0
 8000408:	460d      	mov	r5, r1
 800040a:	4614      	mov	r4, r2
 800040c:	f7ff ff7a 	bl	8000304 <rgb_i2cStart>
 8000410:	4630      	mov	r0, r6
 8000412:	f7ff ff95 	bl	8000340 <rgb_i2cWrite>
 8000416:	4628      	mov	r0, r5
 8000418:	f7ff ff92 	bl	8000340 <rgb_i2cWrite>
 800041c:	4620      	mov	r0, r4
 800041e:	f7ff ff8f 	bl	8000340 <rgb_i2cWrite>
 8000422:	e8bd 4070 	ldmia.w	sp!, {r4, r5, r6, lr}
 8000426:	f7ff bf7c 	b.w	8000322 <rgb_i2cStop>

0800042a <rgb_i2c_read_reg>:
 800042a:	b570      	push	{r4, r5, r6, lr}
 800042c:	4604      	mov	r4, r0
 800042e:	460e      	mov	r6, r1
 8000430:	4615      	mov	r5, r2
 8000432:	f7ff ff67 	bl	8000304 <rgb_i2cStart>
 8000436:	4620      	mov	r0, r4
 8000438:	f7ff ff82 	bl	8000340 <rgb_i2cWrite>
 800043c:	4630      	mov	r0, r6
 800043e:	f7ff ff7f 	bl	8000340 <rgb_i2cWrite>
 8000442:	f7ff ff5f 	bl	8000304 <rgb_i2cStart>
 8000446:	f044 0001 	orr.w	r0, r4, #1
 800044a:	f7ff ff79 	bl	8000340 <rgb_i2cWrite>
 800044e:	4629      	mov	r1, r5
 8000450:	2000      	movs	r0, #0
 8000452:	f7ff ff95 	bl	8000380 <rgb_i2cRead>
 8000456:	e8bd 4070 	ldmia.w	sp!, {r4, r5, r6, lr}
 800045a:	f7ff bf62 	b.w	8000322 <rgb_i2cStop>

0800045e <lsm9ds0_uninit>:
 800045e:	b508      	push	{r3, lr}
 8000460:	20d4      	movs	r0, #212	; 0xd4
 8000462:	2120      	movs	r1, #32
 8000464:	2200      	movs	r2, #0
 8000466:	f002 fbe1 	bl	8002c2c <i2c_write_reg>
 800046a:	203c      	movs	r0, #60	; 0x3c
 800046c:	2120      	movs	r1, #32
 800046e:	2200      	movs	r2, #0
 8000470:	f002 fbdc 	bl	8002c2c <i2c_write_reg>
 8000474:	203c      	movs	r0, #60	; 0x3c
 8000476:	2124      	movs	r1, #36	; 0x24
 8000478:	2200      	movs	r2, #0
 800047a:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 800047e:	f002 bbd5 	b.w	8002c2c <i2c_write_reg>
	...

08000484 <lsm9ds0_read>:
 8000484:	b538      	push	{r3, r4, r5, lr}
 8000486:	2128      	movs	r1, #40	; 0x28
 8000488:	20d4      	movs	r0, #212	; 0xd4
 800048a:	f002 fbe2 	bl	8002c52 <i2c_read_reg>
 800048e:	2129      	movs	r1, #41	; 0x29
 8000490:	4604      	mov	r4, r0
 8000492:	20d4      	movs	r0, #212	; 0xd4
 8000494:	f002 fbdd 	bl	8002c52 <i2c_read_reg>
 8000498:	ea44 2000 	orr.w	r0, r4, r0, lsl #8
 800049c:	4c43      	ldr	r4, [pc, #268]	; (80005ac <lsm9ds0_read+0x128>)
 800049e:	b280      	uxth	r0, r0
 80004a0:	81a0      	strh	r0, [r4, #12]
 80004a2:	89a3      	ldrh	r3, [r4, #12]
 80004a4:	8a62      	ldrh	r2, [r4, #18]
 80004a6:	1a9b      	subs	r3, r3, r2
 80004a8:	b29b      	uxth	r3, r3
 80004aa:	212a      	movs	r1, #42	; 0x2a
 80004ac:	20d4      	movs	r0, #212	; 0xd4
 80004ae:	8323      	strh	r3, [r4, #24]
 80004b0:	f002 fbcf 	bl	8002c52 <i2c_read_reg>
 80004b4:	212b      	movs	r1, #43	; 0x2b
 80004b6:	4605      	mov	r5, r0
 80004b8:	20d4      	movs	r0, #212	; 0xd4
 80004ba:	f002 fbca 	bl	8002c52 <i2c_read_reg>
 80004be:	ea45 2000 	orr.w	r0, r5, r0, lsl #8
 80004c2:	b280      	uxth	r0, r0
 80004c4:	81e0      	strh	r0, [r4, #14]
 80004c6:	89e3      	ldrh	r3, [r4, #14]
 80004c8:	8aa2      	ldrh	r2, [r4, #20]
 80004ca:	1a9b      	subs	r3, r3, r2
 80004cc:	b29b      	uxth	r3, r3
 80004ce:	212c      	movs	r1, #44	; 0x2c
 80004d0:	20d4      	movs	r0, #212	; 0xd4
 80004d2:	8363      	strh	r3, [r4, #26]
 80004d4:	f002 fbbd 	bl	8002c52 <i2c_read_reg>
 80004d8:	212d      	movs	r1, #45	; 0x2d
 80004da:	4605      	mov	r5, r0
 80004dc:	20d4      	movs	r0, #212	; 0xd4
 80004de:	f002 fbb8 	bl	8002c52 <i2c_read_reg>
 80004e2:	ea45 2000 	orr.w	r0, r5, r0, lsl #8
 80004e6:	b280      	uxth	r0, r0
 80004e8:	8220      	strh	r0, [r4, #16]
 80004ea:	8a23      	ldrh	r3, [r4, #16]
 80004ec:	8ae2      	ldrh	r2, [r4, #22]
 80004ee:	1a9b      	subs	r3, r3, r2
 80004f0:	b29b      	uxth	r3, r3
 80004f2:	2108      	movs	r1, #8
 80004f4:	203c      	movs	r0, #60	; 0x3c
 80004f6:	83a3      	strh	r3, [r4, #28]
 80004f8:	f002 fbab 	bl	8002c52 <i2c_read_reg>
 80004fc:	2109      	movs	r1, #9
 80004fe:	4605      	mov	r5, r0
 8000500:	203c      	movs	r0, #60	; 0x3c
 8000502:	f002 fba6 	bl	8002c52 <i2c_read_reg>
 8000506:	ea45 2000 	orr.w	r0, r5, r0, lsl #8
 800050a:	b280      	uxth	r0, r0
 800050c:	80e0      	strh	r0, [r4, #6]
 800050e:	210a      	movs	r1, #10
 8000510:	203c      	movs	r0, #60	; 0x3c
 8000512:	f002 fb9e 	bl	8002c52 <i2c_read_reg>
 8000516:	210b      	movs	r1, #11
 8000518:	4605      	mov	r5, r0
 800051a:	203c      	movs	r0, #60	; 0x3c
 800051c:	f002 fb99 	bl	8002c52 <i2c_read_reg>
 8000520:	ea45 2000 	orr.w	r0, r5, r0, lsl #8
 8000524:	b280      	uxth	r0, r0
 8000526:	8120      	strh	r0, [r4, #8]
 8000528:	210c      	movs	r1, #12
 800052a:	203c      	movs	r0, #60	; 0x3c
 800052c:	f002 fb91 	bl	8002c52 <i2c_read_reg>
 8000530:	210d      	movs	r1, #13
 8000532:	4605      	mov	r5, r0
 8000534:	203c      	movs	r0, #60	; 0x3c
 8000536:	f002 fb8c 	bl	8002c52 <i2c_read_reg>
 800053a:	ea45 2000 	orr.w	r0, r5, r0, lsl #8
 800053e:	b280      	uxth	r0, r0
 8000540:	8160      	strh	r0, [r4, #10]
 8000542:	2128      	movs	r1, #40	; 0x28
 8000544:	203c      	movs	r0, #60	; 0x3c
 8000546:	f002 fb84 	bl	8002c52 <i2c_read_reg>
 800054a:	2129      	movs	r1, #41	; 0x29
 800054c:	4605      	mov	r5, r0
 800054e:	203c      	movs	r0, #60	; 0x3c
 8000550:	f002 fb7f 	bl	8002c52 <i2c_read_reg>
 8000554:	ea45 2000 	orr.w	r0, r5, r0, lsl #8
 8000558:	b280      	uxth	r0, r0
 800055a:	8020      	strh	r0, [r4, #0]
 800055c:	212a      	movs	r1, #42	; 0x2a
 800055e:	203c      	movs	r0, #60	; 0x3c
 8000560:	f002 fb77 	bl	8002c52 <i2c_read_reg>
 8000564:	212b      	movs	r1, #43	; 0x2b
 8000566:	4605      	mov	r5, r0
 8000568:	203c      	movs	r0, #60	; 0x3c
 800056a:	f002 fb72 	bl	8002c52 <i2c_read_reg>
 800056e:	ea45 2000 	orr.w	r0, r5, r0, lsl #8
 8000572:	b280      	uxth	r0, r0
 8000574:	8060      	strh	r0, [r4, #2]
 8000576:	212c      	movs	r1, #44	; 0x2c
 8000578:	203c      	movs	r0, #60	; 0x3c
 800057a:	f002 fb6a 	bl	8002c52 <i2c_read_reg>
 800057e:	212d      	movs	r1, #45	; 0x2d
 8000580:	4605      	mov	r5, r0
 8000582:	203c      	movs	r0, #60	; 0x3c
 8000584:	f002 fb65 	bl	8002c52 <i2c_read_reg>
 8000588:	ea45 2000 	orr.w	r0, r5, r0, lsl #8
 800058c:	b280      	uxth	r0, r0
 800058e:	80a0      	strh	r0, [r4, #4]
 8000590:	2105      	movs	r1, #5
 8000592:	203c      	movs	r0, #60	; 0x3c
 8000594:	f002 fb5d 	bl	8002c52 <i2c_read_reg>
 8000598:	2106      	movs	r1, #6
 800059a:	4605      	mov	r5, r0
 800059c:	203c      	movs	r0, #60	; 0x3c
 800059e:	f002 fb58 	bl	8002c52 <i2c_read_reg>
 80005a2:	ea45 2000 	orr.w	r0, r5, r0, lsl #8
 80005a6:	b280      	uxth	r0, r0
 80005a8:	85a0      	strh	r0, [r4, #44]	; 0x2c
 80005aa:	bd38      	pop	{r3, r4, r5, pc}
 80005ac:	20000034 	.word	0x20000034

080005b0 <lsm9ds0_calibrate>:
 80005b0:	e92d 43f8 	stmdb	sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
 80005b4:	2400      	movs	r4, #0
 80005b6:	4681      	mov	r9, r0
 80005b8:	4625      	mov	r5, r4
 80005ba:	4626      	mov	r6, r4
 80005bc:	46a0      	mov	r8, r4
 80005be:	45c8      	cmp	r8, r9
 80005c0:	4f10      	ldr	r7, [pc, #64]	; (8000604 <lsm9ds0_calibrate+0x54>)
 80005c2:	d010      	beq.n	80005e6 <lsm9ds0_calibrate+0x36>
 80005c4:	f7ff ff5e 	bl	8000484 <lsm9ds0_read>
 80005c8:	89bb      	ldrh	r3, [r7, #12]
 80005ca:	fa06 f683 	sxtah	r6, r6, r3
 80005ce:	89fb      	ldrh	r3, [r7, #14]
 80005d0:	fa05 f583 	sxtah	r5, r5, r3
 80005d4:	8a3b      	ldrh	r3, [r7, #16]
 80005d6:	200a      	movs	r0, #10
 80005d8:	fa04 f483 	sxtah	r4, r4, r3
 80005dc:	f108 0801 	add.w	r8, r8, #1
 80005e0:	f001 fc0c 	bl	8001dfc <timer_delay_ms>
 80005e4:	e7eb      	b.n	80005be <lsm9ds0_calibrate+0xe>
 80005e6:	fb96 f6f8 	sdiv	r6, r6, r8
 80005ea:	fb95 f5f8 	sdiv	r5, r5, r8
 80005ee:	b2b6      	uxth	r6, r6
 80005f0:	b2ad      	uxth	r5, r5
 80005f2:	fb94 f4f8 	sdiv	r4, r4, r8
 80005f6:	b2a4      	uxth	r4, r4
 80005f8:	827e      	strh	r6, [r7, #18]
 80005fa:	82bd      	strh	r5, [r7, #20]
 80005fc:	82fc      	strh	r4, [r7, #22]
 80005fe:	e8bd 83f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
 8000602:	bf00      	nop
 8000604:	20000034 	.word	0x20000034

08000608 <lsm9ds0_init>:
 8000608:	4b29      	ldr	r3, [pc, #164]	; (80006b0 <lsm9ds0_init+0xa8>)
 800060a:	b570      	push	{r4, r5, r6, lr}
 800060c:	210f      	movs	r1, #15
 800060e:	2400      	movs	r4, #0
 8000610:	4606      	mov	r6, r0
 8000612:	20d4      	movs	r0, #212	; 0xd4
 8000614:	801c      	strh	r4, [r3, #0]
 8000616:	805c      	strh	r4, [r3, #2]
 8000618:	809c      	strh	r4, [r3, #4]
 800061a:	80dc      	strh	r4, [r3, #6]
 800061c:	811c      	strh	r4, [r3, #8]
 800061e:	815c      	strh	r4, [r3, #10]
 8000620:	819c      	strh	r4, [r3, #12]
 8000622:	81dc      	strh	r4, [r3, #14]
 8000624:	821c      	strh	r4, [r3, #16]
 8000626:	831c      	strh	r4, [r3, #24]
 8000628:	835c      	strh	r4, [r3, #26]
 800062a:	839c      	strh	r4, [r3, #28]
 800062c:	859c      	strh	r4, [r3, #44]	; 0x2c
 800062e:	f002 fb10 	bl	8002c52 <i2c_read_reg>
 8000632:	28d4      	cmp	r0, #212	; 0xd4
 8000634:	4605      	mov	r5, r0
 8000636:	d137      	bne.n	80006a8 <lsm9ds0_init+0xa0>
 8000638:	203c      	movs	r0, #60	; 0x3c
 800063a:	210f      	movs	r1, #15
 800063c:	f002 fb09 	bl	8002c52 <i2c_read_reg>
 8000640:	2849      	cmp	r0, #73	; 0x49
 8000642:	d133      	bne.n	80006ac <lsm9ds0_init+0xa4>
 8000644:	4628      	mov	r0, r5
 8000646:	2120      	movs	r1, #32
 8000648:	22ff      	movs	r2, #255	; 0xff
 800064a:	f002 faef 	bl	8002c2c <i2c_write_reg>
 800064e:	4628      	mov	r0, r5
 8000650:	2123      	movs	r1, #35	; 0x23
 8000652:	2218      	movs	r2, #24
 8000654:	f002 faea 	bl	8002c2c <i2c_write_reg>
 8000658:	203c      	movs	r0, #60	; 0x3c
 800065a:	211f      	movs	r1, #31
 800065c:	4622      	mov	r2, r4
 800065e:	f002 fae5 	bl	8002c2c <i2c_write_reg>
 8000662:	203c      	movs	r0, #60	; 0x3c
 8000664:	2120      	movs	r1, #32
 8000666:	2267      	movs	r2, #103	; 0x67
 8000668:	f002 fae0 	bl	8002c2c <i2c_write_reg>
 800066c:	203c      	movs	r0, #60	; 0x3c
 800066e:	2121      	movs	r1, #33	; 0x21
 8000670:	4622      	mov	r2, r4
 8000672:	f002 fadb 	bl	8002c2c <i2c_write_reg>
 8000676:	203c      	movs	r0, #60	; 0x3c
 8000678:	2124      	movs	r1, #36	; 0x24
 800067a:	22f4      	movs	r2, #244	; 0xf4
 800067c:	f002 fad6 	bl	8002c2c <i2c_write_reg>
 8000680:	203c      	movs	r0, #60	; 0x3c
 8000682:	2125      	movs	r1, #37	; 0x25
 8000684:	4622      	mov	r2, r4
 8000686:	f002 fad1 	bl	8002c2c <i2c_write_reg>
 800068a:	203c      	movs	r0, #60	; 0x3c
 800068c:	2126      	movs	r1, #38	; 0x26
 800068e:	2280      	movs	r2, #128	; 0x80
 8000690:	f002 facc 	bl	8002c2c <i2c_write_reg>
 8000694:	f7ff fef6 	bl	8000484 <lsm9ds0_read>
 8000698:	b116      	cbz	r6, 80006a0 <lsm9ds0_init+0x98>
 800069a:	2064      	movs	r0, #100	; 0x64
 800069c:	f7ff ff88 	bl	80005b0 <lsm9ds0_calibrate>
 80006a0:	f7ff fef0 	bl	8000484 <lsm9ds0_read>
 80006a4:	2000      	movs	r0, #0
 80006a6:	bd70      	pop	{r4, r5, r6, pc}
 80006a8:	2001      	movs	r0, #1
 80006aa:	bd70      	pop	{r4, r5, r6, pc}
 80006ac:	2002      	movs	r0, #2
 80006ae:	bd70      	pop	{r4, r5, r6, pc}
 80006b0:	20000034 	.word	0x20000034

080006b4 <rgb_sensor_uninit>:
 80006b4:	b508      	push	{r3, lr}
 80006b6:	2008      	movs	r0, #8
 80006b8:	f002 f8ea 	bl	8002890 <led_off>
 80006bc:	2072      	movs	r0, #114	; 0x72
 80006be:	2180      	movs	r1, #128	; 0x80
 80006c0:	2200      	movs	r2, #0
 80006c2:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 80006c6:	f7ff be9d 	b.w	8000404 <rgb_i2c_write_reg>
	...

080006cc <rgb_sensor_read>:
 80006cc:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
 80006ce:	f7ff fe19 	bl	8000304 <rgb_i2cStart>
 80006d2:	2072      	movs	r0, #114	; 0x72
 80006d4:	4d70      	ldr	r5, [pc, #448]	; (8000898 <rgb_sensor_read+0x1cc>)
 80006d6:	4c71      	ldr	r4, [pc, #452]	; (800089c <rgb_sensor_read+0x1d0>)
 80006d8:	f7ff fe32 	bl	8000340 <rgb_i2cWrite>
 80006dc:	20b4      	movs	r0, #180	; 0xb4
 80006de:	f7ff fe2f 	bl	8000340 <rgb_i2cWrite>
 80006e2:	f7ff fe0f 	bl	8000304 <rgb_i2cStart>
 80006e6:	2073      	movs	r0, #115	; 0x73
 80006e8:	f7ff fe2a 	bl	8000340 <rgb_i2cWrite>
 80006ec:	2001      	movs	r0, #1
 80006ee:	4629      	mov	r1, r5
 80006f0:	f7ff fe46 	bl	8000380 <rgb_i2cRead>
 80006f4:	782b      	ldrb	r3, [r5, #0]
 80006f6:	8323      	strh	r3, [r4, #24]
 80006f8:	786b      	ldrb	r3, [r5, #1]
 80006fa:	8363      	strh	r3, [r4, #26]
 80006fc:	78ab      	ldrb	r3, [r5, #2]
 80006fe:	83a3      	strh	r3, [r4, #28]
 8000700:	2001      	movs	r0, #1
 8000702:	78eb      	ldrb	r3, [r5, #3]
 8000704:	83e3      	strh	r3, [r4, #30]
 8000706:	4629      	mov	r1, r5
 8000708:	f7ff fe3a 	bl	8000380 <rgb_i2cRead>
 800070c:	2300      	movs	r3, #0
 800070e:	f103 010c 	add.w	r1, r3, #12
 8000712:	5ce8      	ldrb	r0, [r5, r3]
 8000714:	f834 2011 	ldrh.w	r2, [r4, r1, lsl #1]
 8000718:	4f60      	ldr	r7, [pc, #384]	; (800089c <rgb_sensor_read+0x1d0>)
 800071a:	4e5f      	ldr	r6, [pc, #380]	; (8000898 <rgb_sensor_read+0x1cc>)
 800071c:	b292      	uxth	r2, r2
 800071e:	3301      	adds	r3, #1
 8000720:	ea42 2200 	orr.w	r2, r2, r0, lsl #8
 8000724:	2b04      	cmp	r3, #4
 8000726:	f824 2011 	strh.w	r2, [r4, r1, lsl #1]
 800072a:	d1f0      	bne.n	800070e <rgb_sensor_read+0x42>
 800072c:	2001      	movs	r0, #1
 800072e:	4631      	mov	r1, r6
 8000730:	f7ff fe26 	bl	8000380 <rgb_i2cRead>
 8000734:	7833      	ldrb	r3, [r6, #0]
 8000736:	803b      	strh	r3, [r7, #0]
 8000738:	7873      	ldrb	r3, [r6, #1]
 800073a:	807b      	strh	r3, [r7, #2]
 800073c:	78b3      	ldrb	r3, [r6, #2]
 800073e:	80bb      	strh	r3, [r7, #4]
 8000740:	2001      	movs	r0, #1
 8000742:	78f3      	ldrb	r3, [r6, #3]
 8000744:	80fb      	strh	r3, [r7, #6]
 8000746:	4631      	mov	r1, r6
 8000748:	f7ff fe1a 	bl	8000380 <rgb_i2cRead>
 800074c:	2300      	movs	r3, #0
 800074e:	f834 2013 	ldrh.w	r2, [r4, r3, lsl #1]
 8000752:	5ce9      	ldrb	r1, [r5, r3]
 8000754:	4f51      	ldr	r7, [pc, #324]	; (800089c <rgb_sensor_read+0x1d0>)
 8000756:	4e50      	ldr	r6, [pc, #320]	; (8000898 <rgb_sensor_read+0x1cc>)
 8000758:	b292      	uxth	r2, r2
 800075a:	ea42 2201 	orr.w	r2, r2, r1, lsl #8
 800075e:	f824 2013 	strh.w	r2, [r4, r3, lsl #1]
 8000762:	3301      	adds	r3, #1
 8000764:	2b04      	cmp	r3, #4
 8000766:	d1f2      	bne.n	800074e <rgb_sensor_read+0x82>
 8000768:	2001      	movs	r0, #1
 800076a:	4631      	mov	r1, r6
 800076c:	f7ff fe08 	bl	8000380 <rgb_i2cRead>
 8000770:	7833      	ldrb	r3, [r6, #0]
 8000772:	813b      	strh	r3, [r7, #8]
 8000774:	7873      	ldrb	r3, [r6, #1]
 8000776:	817b      	strh	r3, [r7, #10]
 8000778:	78b3      	ldrb	r3, [r6, #2]
 800077a:	81bb      	strh	r3, [r7, #12]
 800077c:	2001      	movs	r0, #1
 800077e:	78f3      	ldrb	r3, [r6, #3]
 8000780:	81fb      	strh	r3, [r7, #14]
 8000782:	4631      	mov	r1, r6
 8000784:	f7ff fdfc 	bl	8000380 <rgb_i2cRead>
 8000788:	2300      	movs	r3, #0
 800078a:	1d19      	adds	r1, r3, #4
 800078c:	5ce8      	ldrb	r0, [r5, r3]
 800078e:	f834 2011 	ldrh.w	r2, [r4, r1, lsl #1]
 8000792:	4f42      	ldr	r7, [pc, #264]	; (800089c <rgb_sensor_read+0x1d0>)
 8000794:	4e40      	ldr	r6, [pc, #256]	; (8000898 <rgb_sensor_read+0x1cc>)
 8000796:	b292      	uxth	r2, r2
 8000798:	3301      	adds	r3, #1
 800079a:	ea42 2200 	orr.w	r2, r2, r0, lsl #8
 800079e:	2b04      	cmp	r3, #4
 80007a0:	f824 2011 	strh.w	r2, [r4, r1, lsl #1]
 80007a4:	d1f1      	bne.n	800078a <rgb_sensor_read+0xbe>
 80007a6:	2001      	movs	r0, #1
 80007a8:	4631      	mov	r1, r6
 80007aa:	f7ff fde9 	bl	8000380 <rgb_i2cRead>
 80007ae:	7833      	ldrb	r3, [r6, #0]
 80007b0:	823b      	strh	r3, [r7, #16]
 80007b2:	7873      	ldrb	r3, [r6, #1]
 80007b4:	827b      	strh	r3, [r7, #18]
 80007b6:	78b3      	ldrb	r3, [r6, #2]
 80007b8:	82bb      	strh	r3, [r7, #20]
 80007ba:	2001      	movs	r0, #1
 80007bc:	78f3      	ldrb	r3, [r6, #3]
 80007be:	82fb      	strh	r3, [r7, #22]
 80007c0:	4631      	mov	r1, r6
 80007c2:	f7ff fddd 	bl	8000380 <rgb_i2cRead>
 80007c6:	2300      	movs	r3, #0
 80007c8:	f103 0108 	add.w	r1, r3, #8
 80007cc:	5ce8      	ldrb	r0, [r5, r3]
 80007ce:	f834 2011 	ldrh.w	r2, [r4, r1, lsl #1]
 80007d2:	4f32      	ldr	r7, [pc, #200]	; (800089c <rgb_sensor_read+0x1d0>)
 80007d4:	4e30      	ldr	r6, [pc, #192]	; (8000898 <rgb_sensor_read+0x1cc>)
 80007d6:	b292      	uxth	r2, r2
 80007d8:	3301      	adds	r3, #1
 80007da:	ea42 2200 	orr.w	r2, r2, r0, lsl #8
 80007de:	2b04      	cmp	r3, #4
 80007e0:	f824 2011 	strh.w	r2, [r4, r1, lsl #1]
 80007e4:	d1f0      	bne.n	80007c8 <rgb_sensor_read+0xfc>
 80007e6:	2001      	movs	r0, #1
 80007e8:	4631      	mov	r1, r6
 80007ea:	f7ff fdc9 	bl	8000380 <rgb_i2cRead>
 80007ee:	7833      	ldrb	r3, [r6, #0]
 80007f0:	843b      	strh	r3, [r7, #32]
 80007f2:	7873      	ldrb	r3, [r6, #1]
 80007f4:	847b      	strh	r3, [r7, #34]	; 0x22
 80007f6:	78b3      	ldrb	r3, [r6, #2]
 80007f8:	84bb      	strh	r3, [r7, #36]	; 0x24
 80007fa:	2000      	movs	r0, #0
 80007fc:	78f3      	ldrb	r3, [r6, #3]
 80007fe:	84fb      	strh	r3, [r7, #38]	; 0x26
 8000800:	4631      	mov	r1, r6
 8000802:	f7ff fdbd 	bl	8000380 <rgb_i2cRead>
 8000806:	2300      	movs	r3, #0
 8000808:	f103 0110 	add.w	r1, r3, #16
 800080c:	5ce8      	ldrb	r0, [r5, r3]
 800080e:	f834 2011 	ldrh.w	r2, [r4, r1, lsl #1]
 8000812:	3301      	adds	r3, #1
 8000814:	b292      	uxth	r2, r2
 8000816:	ea42 2200 	orr.w	r2, r2, r0, lsl #8
 800081a:	2b04      	cmp	r3, #4
 800081c:	f824 2011 	strh.w	r2, [r4, r1, lsl #1]
 8000820:	d1f2      	bne.n	8000808 <rgb_sensor_read+0x13c>
 8000822:	f7ff fd7e 	bl	8000322 <rgb_i2cStop>
 8000826:	2300      	movs	r3, #0
 8000828:	1d1e      	adds	r6, r3, #4
 800082a:	f834 1013 	ldrh.w	r1, [r4, r3, lsl #1]
 800082e:	f834 2016 	ldrh.w	r2, [r4, r6, lsl #1]
 8000832:	f103 0508 	add.w	r5, r3, #8
 8000836:	b212      	sxth	r2, r2
 8000838:	f834 0015 	ldrh.w	r0, [r4, r5, lsl #1]
 800083c:	fa02 f281 	sxtah	r2, r2, r1
 8000840:	f834 1013 	ldrh.w	r1, [r4, r3, lsl #1]
 8000844:	fa02 f080 	sxtah	r0, r2, r0
 8000848:	f103 0734 	add.w	r7, r3, #52	; 0x34
 800084c:	2264      	movs	r2, #100	; 0x64
 800084e:	b289      	uxth	r1, r1
 8000850:	fb11 f102 	smulbb	r1, r1, r2
 8000854:	fb91 f1f0 	sdiv	r1, r1, r0
 8000858:	b289      	uxth	r1, r1
 800085a:	f824 1017 	strh.w	r1, [r4, r7, lsl #1]
 800085e:	f834 1016 	ldrh.w	r1, [r4, r6, lsl #1]
 8000862:	f103 0638 	add.w	r6, r3, #56	; 0x38
 8000866:	b289      	uxth	r1, r1
 8000868:	fb11 f102 	smulbb	r1, r1, r2
 800086c:	fb91 f1f0 	sdiv	r1, r1, r0
 8000870:	b289      	uxth	r1, r1
 8000872:	f824 1016 	strh.w	r1, [r4, r6, lsl #1]
 8000876:	f834 1015 	ldrh.w	r1, [r4, r5, lsl #1]
 800087a:	b289      	uxth	r1, r1
 800087c:	fb11 f202 	smulbb	r2, r1, r2
 8000880:	f103 013c 	add.w	r1, r3, #60	; 0x3c
 8000884:	3301      	adds	r3, #1
 8000886:	fb92 f2f0 	sdiv	r2, r2, r0
 800088a:	2b04      	cmp	r3, #4
 800088c:	b292      	uxth	r2, r2
 800088e:	f824 2011 	strh.w	r2, [r4, r1, lsl #1]
 8000892:	d1c9      	bne.n	8000828 <rgb_sensor_read+0x15c>
 8000894:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
 8000896:	bf00      	nop
 8000898:	20000100 	.word	0x20000100
 800089c:	20000064 	.word	0x20000064

080008a0 <rgb_sensor_init>:
 80008a0:	b537      	push	{r0, r1, r2, r4, r5, lr}
 80008a2:	2300      	movs	r3, #0
 80008a4:	4a29      	ldr	r2, [pc, #164]	; (800094c <rgb_sensor_init+0xac>)
 80008a6:	1d19      	adds	r1, r3, #4
 80008a8:	2400      	movs	r4, #0
 80008aa:	f822 4013 	strh.w	r4, [r2, r3, lsl #1]
 80008ae:	f822 4011 	strh.w	r4, [r2, r1, lsl #1]
 80008b2:	f103 0108 	add.w	r1, r3, #8
 80008b6:	f822 4011 	strh.w	r4, [r2, r1, lsl #1]
 80008ba:	f103 0110 	add.w	r1, r3, #16
 80008be:	f822 4011 	strh.w	r4, [r2, r1, lsl #1]
 80008c2:	f103 010c 	add.w	r1, r3, #12
 80008c6:	f822 4011 	strh.w	r4, [r2, r1, lsl #1]
 80008ca:	f103 0134 	add.w	r1, r3, #52	; 0x34
 80008ce:	f822 4011 	strh.w	r4, [r2, r1, lsl #1]
 80008d2:	f103 0138 	add.w	r1, r3, #56	; 0x38
 80008d6:	f822 4011 	strh.w	r4, [r2, r1, lsl #1]
 80008da:	f103 013c 	add.w	r1, r3, #60	; 0x3c
 80008de:	3301      	adds	r3, #1
 80008e0:	2b04      	cmp	r3, #4
 80008e2:	f822 4011 	strh.w	r4, [r2, r1, lsl #1]
 80008e6:	d1dd      	bne.n	80008a4 <rgb_sensor_init+0x4>
 80008e8:	f7ff fcdc 	bl	80002a4 <rgb_i2c_init>
 80008ec:	2072      	movs	r0, #114	; 0x72
 80008ee:	2181      	movs	r1, #129	; 0x81
 80008f0:	22ff      	movs	r2, #255	; 0xff
 80008f2:	f7ff fd87 	bl	8000404 <rgb_i2c_write_reg>
 80008f6:	2072      	movs	r0, #114	; 0x72
 80008f8:	2183      	movs	r1, #131	; 0x83
 80008fa:	22ff      	movs	r2, #255	; 0xff
 80008fc:	f7ff fd82 	bl	8000404 <rgb_i2c_write_reg>
 8000900:	2072      	movs	r0, #114	; 0x72
 8000902:	218d      	movs	r1, #141	; 0x8d
 8000904:	4622      	mov	r2, r4
 8000906:	f7ff fd7d 	bl	8000404 <rgb_i2c_write_reg>
 800090a:	2072      	movs	r0, #114	; 0x72
 800090c:	2180      	movs	r1, #128	; 0x80
 800090e:	2203      	movs	r2, #3
 8000910:	f7ff fd78 	bl	8000404 <rgb_i2c_write_reg>
 8000914:	ad01      	add	r5, sp, #4
 8000916:	2072      	movs	r0, #114	; 0x72
 8000918:	218f      	movs	r1, #143	; 0x8f
 800091a:	2223      	movs	r2, #35	; 0x23
 800091c:	f7ff fd72 	bl	8000404 <rgb_i2c_write_reg>
 8000920:	f7ff fed4 	bl	80006cc <rgb_sensor_read>
 8000924:	2072      	movs	r0, #114	; 0x72
 8000926:	2192      	movs	r1, #146	; 0x92
 8000928:	462a      	mov	r2, r5
 800092a:	f7ff fd7e 	bl	800042a <rgb_i2c_read_reg>
 800092e:	4620      	mov	r0, r4
 8000930:	4623      	mov	r3, r4
 8000932:	5cea      	ldrb	r2, [r5, r3]
 8000934:	2a69      	cmp	r2, #105	; 0x69
 8000936:	bf1c      	itt	ne
 8000938:	2201      	movne	r2, #1
 800093a:	409a      	lslne	r2, r3
 800093c:	f103 0301 	add.w	r3, r3, #1
 8000940:	bf18      	it	ne
 8000942:	4310      	orrne	r0, r2
 8000944:	2b04      	cmp	r3, #4
 8000946:	d1f4      	bne.n	8000932 <rgb_sensor_init+0x92>
 8000948:	b003      	add	sp, #12
 800094a:	bd30      	pop	{r4, r5, pc}
 800094c:	20000064 	.word	0x20000064

08000950 <rgb_get_line_position>:
 8000950:	4b54      	ldr	r3, [pc, #336]	; (8000aa4 <rgb_get_line_position+0x154>)
 8000952:	b5f0      	push	{r4, r5, r6, r7, lr}
 8000954:	cb0f      	ldmia	r3, {r0, r1, r2, r3}
 8000956:	b085      	sub	sp, #20
 8000958:	e88d 000f 	stmia.w	sp, {r0, r1, r2, r3}
 800095c:	2200      	movs	r2, #0
 800095e:	466c      	mov	r4, sp
 8000960:	4615      	mov	r5, r2
 8000962:	4611      	mov	r1, r2
 8000964:	4b50      	ldr	r3, [pc, #320]	; (8000aa8 <rgb_get_line_position+0x158>)
 8000966:	f101 0e0c 	add.w	lr, r1, #12
 800096a:	f101 060a 	add.w	r6, r1, #10
 800096e:	f833 001e 	ldrh.w	r0, [r3, lr, lsl #1]
 8000972:	f853 7026 	ldr.w	r7, [r3, r6, lsl #2]
 8000976:	b200      	sxth	r0, r0
 8000978:	1bc0      	subs	r0, r0, r7
 800097a:	f854 7021 	ldr.w	r7, [r4, r1, lsl #2]
 800097e:	fb07 2200 	mla	r2, r7, r0, r2
 8000982:	f833 001e 	ldrh.w	r0, [r3, lr, lsl #1]
 8000986:	f853 6026 	ldr.w	r6, [r3, r6, lsl #2]
 800098a:	b200      	sxth	r0, r0
 800098c:	3101      	adds	r1, #1
 800098e:	1b80      	subs	r0, r0, r6
 8000990:	2904      	cmp	r1, #4
 8000992:	4405      	add	r5, r0
 8000994:	d1e6      	bne.n	8000964 <rgb_get_line_position+0x14>
 8000996:	4945      	ldr	r1, [pc, #276]	; (8000aac <rgb_get_line_position+0x15c>)
 8000998:	f5b5 7f7a 	cmp.w	r5, #1000	; 0x3e8
 800099c:	f04f 0000 	mov.w	r0, #0
 80009a0:	7408      	strb	r0, [r1, #16]
 80009a2:	bfc1      	itttt	gt
 80009a4:	fb92 f2f5 	sdivgt	r2, r2, r5
 80009a8:	2001      	movgt	r0, #1
 80009aa:	3a47      	subgt	r2, #71	; 0x47
 80009ac:	7408      	strbgt	r0, [r1, #16]
 80009ae:	bfc8      	it	gt
 80009b0:	600a      	strgt	r2, [r1, #0]
 80009b2:	2200      	movs	r2, #0
 80009b4:	4616      	mov	r6, r2
 80009b6:	4610      	mov	r0, r2
 80009b8:	f100 0e0e 	add.w	lr, r0, #14
 80009bc:	f833 5010 	ldrh.w	r5, [r3, r0, lsl #1]
 80009c0:	f853 702e 	ldr.w	r7, [r3, lr, lsl #2]
 80009c4:	b22d      	sxth	r5, r5
 80009c6:	1bed      	subs	r5, r5, r7
 80009c8:	f854 7020 	ldr.w	r7, [r4, r0, lsl #2]
 80009cc:	fb07 2205 	mla	r2, r7, r5, r2
 80009d0:	f833 5010 	ldrh.w	r5, [r3, r0, lsl #1]
 80009d4:	f853 702e 	ldr.w	r7, [r3, lr, lsl #2]
 80009d8:	b22d      	sxth	r5, r5
 80009da:	3001      	adds	r0, #1
 80009dc:	1bed      	subs	r5, r5, r7
 80009de:	2804      	cmp	r0, #4
 80009e0:	442e      	add	r6, r5
 80009e2:	d1e9      	bne.n	80009b8 <rgb_get_line_position+0x68>
 80009e4:	2e28      	cmp	r6, #40	; 0x28
 80009e6:	4831      	ldr	r0, [pc, #196]	; (8000aac <rgb_get_line_position+0x15c>)
 80009e8:	bfc8      	it	gt
 80009ea:	fb92 f2f6 	sdivgt	r2, r2, r6
 80009ee:	f04f 0500 	mov.w	r5, #0
 80009f2:	744d      	strb	r5, [r1, #17]
 80009f4:	bfc1      	itttt	gt
 80009f6:	3a47      	subgt	r2, #71	; 0x47
 80009f8:	2501      	movgt	r5, #1
 80009fa:	7445      	strbgt	r5, [r0, #17]
 80009fc:	6042      	strgt	r2, [r0, #4]
 80009fe:	2200      	movs	r2, #0
 8000a00:	4616      	mov	r6, r2
 8000a02:	4610      	mov	r0, r2
 8000a04:	f100 0c04 	add.w	ip, r0, #4
 8000a08:	f100 0e12 	add.w	lr, r0, #18
 8000a0c:	f833 501c 	ldrh.w	r5, [r3, ip, lsl #1]
 8000a10:	f853 702e 	ldr.w	r7, [r3, lr, lsl #2]
 8000a14:	b22d      	sxth	r5, r5
 8000a16:	1bed      	subs	r5, r5, r7
 8000a18:	f854 7020 	ldr.w	r7, [r4, r0, lsl #2]
 8000a1c:	fb07 2205 	mla	r2, r7, r5, r2
 8000a20:	f833 501c 	ldrh.w	r5, [r3, ip, lsl #1]
 8000a24:	f853 702e 	ldr.w	r7, [r3, lr, lsl #2]
 8000a28:	b22d      	sxth	r5, r5
 8000a2a:	3001      	adds	r0, #1
 8000a2c:	1bed      	subs	r5, r5, r7
 8000a2e:	2804      	cmp	r0, #4
 8000a30:	442e      	add	r6, r5
 8000a32:	d1e7      	bne.n	8000a04 <rgb_get_line_position+0xb4>
 8000a34:	2e0a      	cmp	r6, #10
 8000a36:	481d      	ldr	r0, [pc, #116]	; (8000aac <rgb_get_line_position+0x15c>)
 8000a38:	bfc8      	it	gt
 8000a3a:	fb92 f2f6 	sdivgt	r2, r2, r6
 8000a3e:	f04f 0500 	mov.w	r5, #0
 8000a42:	748d      	strb	r5, [r1, #18]
 8000a44:	bfc1      	itttt	gt
 8000a46:	3a47      	subgt	r2, #71	; 0x47
 8000a48:	2501      	movgt	r5, #1
 8000a4a:	7485      	strbgt	r5, [r0, #18]
 8000a4c:	6082      	strgt	r2, [r0, #8]
 8000a4e:	2200      	movs	r2, #0
 8000a50:	4616      	mov	r6, r2
 8000a52:	4610      	mov	r0, r2
 8000a54:	f100 0c08 	add.w	ip, r0, #8
 8000a58:	f100 0e16 	add.w	lr, r0, #22
 8000a5c:	f833 501c 	ldrh.w	r5, [r3, ip, lsl #1]
 8000a60:	f853 702e 	ldr.w	r7, [r3, lr, lsl #2]
 8000a64:	b22d      	sxth	r5, r5
 8000a66:	1bed      	subs	r5, r5, r7
 8000a68:	f854 7020 	ldr.w	r7, [r4, r0, lsl #2]
 8000a6c:	fb07 2205 	mla	r2, r7, r5, r2
 8000a70:	f833 501c 	ldrh.w	r5, [r3, ip, lsl #1]
 8000a74:	f853 702e 	ldr.w	r7, [r3, lr, lsl #2]
 8000a78:	b22d      	sxth	r5, r5
 8000a7a:	3001      	adds	r0, #1
 8000a7c:	1bed      	subs	r5, r5, r7
 8000a7e:	2804      	cmp	r0, #4
 8000a80:	442e      	add	r6, r5
 8000a82:	d1e7      	bne.n	8000a54 <rgb_get_line_position+0x104>
 8000a84:	2e0a      	cmp	r6, #10
 8000a86:	4b09      	ldr	r3, [pc, #36]	; (8000aac <rgb_get_line_position+0x15c>)
 8000a88:	bfc8      	it	gt
 8000a8a:	fb92 f2f6 	sdivgt	r2, r2, r6
 8000a8e:	f04f 0000 	mov.w	r0, #0
 8000a92:	74c8      	strb	r0, [r1, #19]
 8000a94:	bfc1      	itttt	gt
 8000a96:	3a47      	subgt	r2, #71	; 0x47
 8000a98:	2101      	movgt	r1, #1
 8000a9a:	74d9      	strbgt	r1, [r3, #19]
 8000a9c:	60da      	strgt	r2, [r3, #12]
 8000a9e:	b005      	add	sp, #20
 8000aa0:	bdf0      	pop	{r4, r5, r6, r7, pc}
 8000aa2:	bf00      	nop
 8000aa4:	08002cb4 	.word	0x08002cb4
 8000aa8:	20000064 	.word	0x20000064
 8000aac:	200000ec 	.word	0x200000ec

08000ab0 <rgb_set_background>:
 8000ab0:	b530      	push	{r4, r5, lr}
 8000ab2:	2200      	movs	r2, #0
 8000ab4:	4b36      	ldr	r3, [pc, #216]	; (8000b90 <rgb_set_background+0xe0>)
 8000ab6:	f102 000a 	add.w	r0, r2, #10
 8000aba:	2100      	movs	r1, #0
 8000abc:	f843 1020 	str.w	r1, [r3, r0, lsl #2]
 8000ac0:	f102 000e 	add.w	r0, r2, #14
 8000ac4:	f843 1020 	str.w	r1, [r3, r0, lsl #2]
 8000ac8:	f102 0016 	add.w	r0, r2, #22
 8000acc:	f843 1020 	str.w	r1, [r3, r0, lsl #2]
 8000ad0:	f102 0012 	add.w	r0, r2, #18
 8000ad4:	3201      	adds	r2, #1
 8000ad6:	2a04      	cmp	r2, #4
 8000ad8:	f843 1020 	str.w	r1, [r3, r0, lsl #2]
 8000adc:	d1ea      	bne.n	8000ab4 <rgb_set_background+0x4>
 8000ade:	2264      	movs	r2, #100	; 0x64
 8000ae0:	2100      	movs	r1, #0
 8000ae2:	f101 040a 	add.w	r4, r1, #10
 8000ae6:	f101 000c 	add.w	r0, r1, #12
 8000aea:	f833 0010 	ldrh.w	r0, [r3, r0, lsl #1]
 8000aee:	f853 5024 	ldr.w	r5, [r3, r4, lsl #2]
 8000af2:	fa05 f080 	sxtah	r0, r5, r0
 8000af6:	f843 0024 	str.w	r0, [r3, r4, lsl #2]
 8000afa:	f101 040e 	add.w	r4, r1, #14
 8000afe:	f833 0011 	ldrh.w	r0, [r3, r1, lsl #1]
 8000b02:	f853 5024 	ldr.w	r5, [r3, r4, lsl #2]
 8000b06:	fa05 f080 	sxtah	r0, r5, r0
 8000b0a:	f843 0024 	str.w	r0, [r3, r4, lsl #2]
 8000b0e:	f101 0416 	add.w	r4, r1, #22
 8000b12:	1d08      	adds	r0, r1, #4
 8000b14:	f833 0010 	ldrh.w	r0, [r3, r0, lsl #1]
 8000b18:	f853 5024 	ldr.w	r5, [r3, r4, lsl #2]
 8000b1c:	fa05 f080 	sxtah	r0, r5, r0
 8000b20:	f843 0024 	str.w	r0, [r3, r4, lsl #2]
 8000b24:	f101 0412 	add.w	r4, r1, #18
 8000b28:	f101 0008 	add.w	r0, r1, #8
 8000b2c:	3101      	adds	r1, #1
 8000b2e:	f833 0010 	ldrh.w	r0, [r3, r0, lsl #1]
 8000b32:	f853 5024 	ldr.w	r5, [r3, r4, lsl #2]
 8000b36:	2904      	cmp	r1, #4
 8000b38:	fa05 f080 	sxtah	r0, r5, r0
 8000b3c:	f843 0024 	str.w	r0, [r3, r4, lsl #2]
 8000b40:	d1cf      	bne.n	8000ae2 <rgb_set_background+0x32>
 8000b42:	3a01      	subs	r2, #1
 8000b44:	d1cc      	bne.n	8000ae0 <rgb_set_background+0x30>
 8000b46:	f102 040a 	add.w	r4, r2, #10
 8000b4a:	2164      	movs	r1, #100	; 0x64
 8000b4c:	f853 0024 	ldr.w	r0, [r3, r4, lsl #2]
 8000b50:	fb90 f0f1 	sdiv	r0, r0, r1
 8000b54:	f843 0024 	str.w	r0, [r3, r4, lsl #2]
 8000b58:	f102 040e 	add.w	r4, r2, #14
 8000b5c:	f853 0024 	ldr.w	r0, [r3, r4, lsl #2]
 8000b60:	fb90 f0f1 	sdiv	r0, r0, r1
 8000b64:	f843 0024 	str.w	r0, [r3, r4, lsl #2]
 8000b68:	f102 0416 	add.w	r4, r2, #22
 8000b6c:	f853 0024 	ldr.w	r0, [r3, r4, lsl #2]
 8000b70:	fb90 f0f1 	sdiv	r0, r0, r1
 8000b74:	f843 0024 	str.w	r0, [r3, r4, lsl #2]
 8000b78:	f102 0412 	add.w	r4, r2, #18
 8000b7c:	3201      	adds	r2, #1
 8000b7e:	2a04      	cmp	r2, #4
 8000b80:	f853 0024 	ldr.w	r0, [r3, r4, lsl #2]
 8000b84:	fb90 f1f1 	sdiv	r1, r0, r1
 8000b88:	f843 1024 	str.w	r1, [r3, r4, lsl #2]
 8000b8c:	d1db      	bne.n	8000b46 <rgb_set_background+0x96>
 8000b8e:	bd30      	pop	{r4, r5, pc}
 8000b90:	20000064 	.word	0x20000064

08000b94 <esp8266_send>:
 8000b94:	b510      	push	{r4, lr}
 8000b96:	1e44      	subs	r4, r0, #1
 8000b98:	f814 0f01 	ldrb.w	r0, [r4, #1]!
 8000b9c:	b110      	cbz	r0, 8000ba4 <esp8266_send+0x10>
 8000b9e:	f001 fcd3 	bl	8002548 <uart_write>
 8000ba2:	e7f9      	b.n	8000b98 <esp8266_send+0x4>
 8000ba4:	bd10      	pop	{r4, pc}

08000ba6 <esp8266_send_uint>:
 8000ba6:	b51f      	push	{r0, r1, r2, r3, r4, lr}
 8000ba8:	2300      	movs	r3, #0
 8000baa:	f88d 300f 	strb.w	r3, [sp, #15]
 8000bae:	220a      	movs	r2, #10
 8000bb0:	230a      	movs	r3, #10
 8000bb2:	a901      	add	r1, sp, #4
 8000bb4:	fbb0 f4f3 	udiv	r4, r0, r3
 8000bb8:	fb03 0314 	mls	r3, r3, r4, r0
 8000bbc:	3330      	adds	r3, #48	; 0x30
 8000bbe:	5453      	strb	r3, [r2, r1]
 8000bc0:	4620      	mov	r0, r4
 8000bc2:	1e53      	subs	r3, r2, #1
 8000bc4:	b10c      	cbz	r4, 8000bca <esp8266_send_uint+0x24>
 8000bc6:	461a      	mov	r2, r3
 8000bc8:	e7f2      	b.n	8000bb0 <esp8266_send_uint+0xa>
 8000bca:	1888      	adds	r0, r1, r2
 8000bcc:	f7ff ffe2 	bl	8000b94 <esp8266_send>
 8000bd0:	b004      	add	sp, #16
 8000bd2:	bd10      	pop	{r4, pc}

08000bd4 <esp8266_find_stream>:
 8000bd4:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
 8000bd6:	4615      	mov	r5, r2
 8000bd8:	460f      	mov	r7, r1
 8000bda:	4606      	mov	r6, r0
 8000bdc:	f001 f900 	bl	8001de0 <timer_get_time>
 8000be0:	4405      	add	r5, r0
 8000be2:	f001 fd5f 	bl	80026a4 <uart_clear_buffer>
 8000be6:	2400      	movs	r4, #0
 8000be8:	f001 fcba 	bl	8002560 <uart_is_char>
 8000bec:	f64f 73ff 	movw	r3, #65535	; 0xffff
 8000bf0:	4298      	cmp	r0, r3
 8000bf2:	d00c      	beq.n	8000c0e <esp8266_find_stream+0x3a>
 8000bf4:	5d33      	ldrb	r3, [r6, r4]
 8000bf6:	4283      	cmp	r3, r0
 8000bf8:	d108      	bne.n	8000c0c <esp8266_find_stream+0x38>
 8000bfa:	1e7b      	subs	r3, r7, #1
 8000bfc:	429c      	cmp	r4, r3
 8000bfe:	d201      	bcs.n	8000c04 <esp8266_find_stream+0x30>
 8000c00:	3401      	adds	r4, #1
 8000c02:	e004      	b.n	8000c0e <esp8266_find_stream+0x3a>
 8000c04:	f001 fd4e 	bl	80026a4 <uart_clear_buffer>
 8000c08:	2001      	movs	r0, #1
 8000c0a:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
 8000c0c:	2400      	movs	r4, #0
 8000c0e:	f001 f8e7 	bl	8001de0 <timer_get_time>
 8000c12:	42a8      	cmp	r0, r5
 8000c14:	d3e8      	bcc.n	8000be8 <esp8266_find_stream+0x14>
 8000c16:	f001 fd45 	bl	80026a4 <uart_clear_buffer>
 8000c1a:	2000      	movs	r0, #0
 8000c1c:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
	...

08000c20 <esp8266_init>:
 8000c20:	4b1d      	ldr	r3, [pc, #116]	; (8000c98 <esp8266_init+0x78>)
 8000c22:	b510      	push	{r4, lr}
 8000c24:	2200      	movs	r2, #0
 8000c26:	4604      	mov	r4, r0
 8000c28:	f640 30b8 	movw	r0, #3000	; 0xbb8
 8000c2c:	601a      	str	r2, [r3, #0]
 8000c2e:	f001 f8e5 	bl	8001dfc <timer_delay_ms>
 8000c32:	b10c      	cbz	r4, 8000c38 <esp8266_init+0x18>
 8000c34:	4819      	ldr	r0, [pc, #100]	; (8000c9c <esp8266_init+0x7c>)
 8000c36:	e000      	b.n	8000c3a <esp8266_init+0x1a>
 8000c38:	4819      	ldr	r0, [pc, #100]	; (8000ca0 <esp8266_init+0x80>)
 8000c3a:	f7ff ffab 	bl	8000b94 <esp8266_send>
 8000c3e:	f44f 707a 	mov.w	r0, #1000	; 0x3e8
 8000c42:	f001 f8db 	bl	8001dfc <timer_delay_ms>
 8000c46:	4817      	ldr	r0, [pc, #92]	; (8000ca4 <esp8266_init+0x84>)
 8000c48:	f7ff ffa4 	bl	8000b94 <esp8266_send>
 8000c4c:	f44f 707a 	mov.w	r0, #1000	; 0x3e8
 8000c50:	f001 f8d4 	bl	8001dfc <timer_delay_ms>
 8000c54:	4814      	ldr	r0, [pc, #80]	; (8000ca8 <esp8266_init+0x88>)
 8000c56:	f7ff ff9d 	bl	8000b94 <esp8266_send>
 8000c5a:	4814      	ldr	r0, [pc, #80]	; (8000cac <esp8266_init+0x8c>)
 8000c5c:	f7ff ff9a 	bl	8000b94 <esp8266_send>
 8000c60:	4813      	ldr	r0, [pc, #76]	; (8000cb0 <esp8266_init+0x90>)
 8000c62:	f7ff ff97 	bl	8000b94 <esp8266_send>
 8000c66:	4813      	ldr	r0, [pc, #76]	; (8000cb4 <esp8266_init+0x94>)
 8000c68:	f7ff ff94 	bl	8000b94 <esp8266_send>
 8000c6c:	4812      	ldr	r0, [pc, #72]	; (8000cb8 <esp8266_init+0x98>)
 8000c6e:	f7ff ff91 	bl	8000b94 <esp8266_send>
 8000c72:	4812      	ldr	r0, [pc, #72]	; (8000cbc <esp8266_init+0x9c>)
 8000c74:	2102      	movs	r1, #2
 8000c76:	f644 6220 	movw	r2, #20000	; 0x4e20
 8000c7a:	f7ff ffab 	bl	8000bd4 <esp8266_find_stream>
 8000c7e:	b140      	cbz	r0, 8000c92 <esp8266_init+0x72>
 8000c80:	b12c      	cbz	r4, 8000c8e <esp8266_init+0x6e>
 8000c82:	480f      	ldr	r0, [pc, #60]	; (8000cc0 <esp8266_init+0xa0>)
 8000c84:	f7ff ff86 	bl	8000b94 <esp8266_send>
 8000c88:	20c8      	movs	r0, #200	; 0xc8
 8000c8a:	f001 f8b7 	bl	8001dfc <timer_delay_ms>
 8000c8e:	2000      	movs	r0, #0
 8000c90:	bd10      	pop	{r4, pc}
 8000c92:	f06f 0001 	mvn.w	r0, #1
 8000c96:	bd10      	pop	{r4, pc}
 8000c98:	20000204 	.word	0x20000204
 8000c9c:	08002cc4 	.word	0x08002cc4
 8000ca0:	08002cd2 	.word	0x08002cd2
 8000ca4:	08002ce0 	.word	0x08002ce0
 8000ca8:	08002cee 	.word	0x08002cee
 8000cac:	08002cf9 	.word	0x08002cf9
 8000cb0:	08002d3e 	.word	0x08002d3e
 8000cb4:	08002cff 	.word	0x08002cff
 8000cb8:	08002d08 	.word	0x08002d08
 8000cbc:	08002d60 	.word	0x08002d60
 8000cc0:	08002d0c 	.word	0x08002d0c

08000cc4 <esp8266_uninit>:
 8000cc4:	4770      	bx	lr

08000cc6 <esp8266_get_nonblocking>:
 8000cc6:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
 8000cc8:	4615      	mov	r5, r2
 8000cca:	4606      	mov	r6, r0
 8000ccc:	460f      	mov	r7, r1
 8000cce:	4603      	mov	r3, r0
 8000cd0:	1842      	adds	r2, r0, r1
 8000cd2:	4293      	cmp	r3, r2
 8000cd4:	f04f 0400 	mov.w	r4, #0
 8000cd8:	d002      	beq.n	8000ce0 <esp8266_get_nonblocking+0x1a>
 8000cda:	f803 4b01 	strb.w	r4, [r3], #1
 8000cde:	e7f8      	b.n	8000cd2 <esp8266_get_nonblocking+0xc>
 8000ce0:	f001 f87e 	bl	8001de0 <timer_get_time>
 8000ce4:	4405      	add	r5, r0
 8000ce6:	f001 fc3b 	bl	8002560 <uart_is_char>
 8000cea:	f64f 73ff 	movw	r3, #65535	; 0xffff
 8000cee:	4298      	cmp	r0, r3
 8000cf0:	bf1c      	itt	ne
 8000cf2:	5530      	strbne	r0, [r6, r4]
 8000cf4:	3401      	addne	r4, #1
 8000cf6:	f001 f873 	bl	8001de0 <timer_get_time>
 8000cfa:	42bc      	cmp	r4, r7
 8000cfc:	d207      	bcs.n	8000d0e <esp8266_get_nonblocking+0x48>
 8000cfe:	4285      	cmp	r5, r0
 8000d00:	d8f1      	bhi.n	8000ce6 <esp8266_get_nonblocking+0x20>
 8000d02:	42a8      	cmp	r0, r5
 8000d04:	bf94      	ite	ls
 8000d06:	4620      	movls	r0, r4
 8000d08:	f04f 30ff 	movhi.w	r0, #4294967295	; 0xffffffff
 8000d0c:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
 8000d0e:	42a8      	cmp	r0, r5
 8000d10:	bf94      	ite	ls
 8000d12:	f06f 0001 	mvnls.w	r0, #1
 8000d16:	f04f 30ff 	movhi.w	r0, #4294967295	; 0xffffffff
 8000d1a:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}

08000d1c <charging_send_message>:
 8000d1c:	e92d 43f8 	stmdb	sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
 8000d20:	4f52      	ldr	r7, [pc, #328]	; (8000e6c <charging_send_message+0x150>)
 8000d22:	461e      	mov	r6, r3
 8000d24:	683b      	ldr	r3, [r7, #0]
 8000d26:	2b01      	cmp	r3, #1
 8000d28:	4681      	mov	r9, r0
 8000d2a:	4688      	mov	r8, r1
 8000d2c:	4614      	mov	r4, r2
 8000d2e:	463d      	mov	r5, r7
 8000d30:	d022      	beq.n	8000d78 <charging_send_message+0x5c>
 8000d32:	484f      	ldr	r0, [pc, #316]	; (8000e70 <charging_send_message+0x154>)
 8000d34:	f7ff ff2e 	bl	8000b94 <esp8266_send>
 8000d38:	2064      	movs	r0, #100	; 0x64
 8000d3a:	f001 f85f 	bl	8001dfc <timer_delay_ms>
 8000d3e:	484d      	ldr	r0, [pc, #308]	; (8000e74 <charging_send_message+0x158>)
 8000d40:	f7ff ff28 	bl	8000b94 <esp8266_send>
 8000d44:	4648      	mov	r0, r9
 8000d46:	f7ff ff25 	bl	8000b94 <esp8266_send>
 8000d4a:	484b      	ldr	r0, [pc, #300]	; (8000e78 <charging_send_message+0x15c>)
 8000d4c:	f7ff ff22 	bl	8000b94 <esp8266_send>
 8000d50:	4640      	mov	r0, r8
 8000d52:	f7ff ff28 	bl	8000ba6 <esp8266_send_uint>
 8000d56:	4849      	ldr	r0, [pc, #292]	; (8000e7c <charging_send_message+0x160>)
 8000d58:	f7ff ff1c 	bl	8000b94 <esp8266_send>
 8000d5c:	4848      	ldr	r0, [pc, #288]	; (8000e80 <charging_send_message+0x164>)
 8000d5e:	2107      	movs	r1, #7
 8000d60:	f242 7210 	movw	r2, #10000	; 0x2710
 8000d64:	f7ff ff36 	bl	8000bd4 <esp8266_find_stream>
 8000d68:	b920      	cbnz	r0, 8000d74 <charging_send_message+0x58>
 8000d6a:	6038      	str	r0, [r7, #0]
 8000d6c:	f06f 0002 	mvn.w	r0, #2
 8000d70:	e8bd 83f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
 8000d74:	2301      	movs	r3, #1
 8000d76:	603b      	str	r3, [r7, #0]
 8000d78:	4842      	ldr	r0, [pc, #264]	; (8000e84 <charging_send_message+0x168>)
 8000d7a:	f7ff ff0b 	bl	8000b94 <esp8266_send>
 8000d7e:	4630      	mov	r0, r6
 8000d80:	f7ff ff11 	bl	8000ba6 <esp8266_send_uint>
 8000d84:	483d      	ldr	r0, [pc, #244]	; (8000e7c <charging_send_message+0x160>)
 8000d86:	f7ff ff05 	bl	8000b94 <esp8266_send>
 8000d8a:	483f      	ldr	r0, [pc, #252]	; (8000e88 <charging_send_message+0x16c>)
 8000d8c:	2101      	movs	r1, #1
 8000d8e:	f242 7210 	movw	r2, #10000	; 0x2710
 8000d92:	f7ff ff1f 	bl	8000bd4 <esp8266_find_stream>
 8000d96:	4607      	mov	r7, r0
 8000d98:	b108      	cbz	r0, 8000d9e <charging_send_message+0x82>
 8000d9a:	4426      	add	r6, r4
 8000d9c:	e012      	b.n	8000dc4 <charging_send_message+0xa8>
 8000d9e:	4834      	ldr	r0, [pc, #208]	; (8000e70 <charging_send_message+0x154>)
 8000da0:	f7ff fef8 	bl	8000b94 <esp8266_send>
 8000da4:	f44f 70fa 	mov.w	r0, #500	; 0x1f4
 8000da8:	f001 f828 	bl	8001dfc <timer_delay_ms>
 8000dac:	4830      	ldr	r0, [pc, #192]	; (8000e70 <charging_send_message+0x154>)
 8000dae:	f7ff fef1 	bl	8000b94 <esp8266_send>
 8000db2:	f44f 70fa 	mov.w	r0, #500	; 0x1f4
 8000db6:	f001 f821 	bl	8001dfc <timer_delay_ms>
 8000dba:	602f      	str	r7, [r5, #0]
 8000dbc:	f06f 0003 	mvn.w	r0, #3
 8000dc0:	e8bd 83f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
 8000dc4:	42b4      	cmp	r4, r6
 8000dc6:	d004      	beq.n	8000dd2 <charging_send_message+0xb6>
 8000dc8:	f814 0b01 	ldrb.w	r0, [r4], #1
 8000dcc:	f001 fbbc 	bl	8002548 <uart_write>
 8000dd0:	e7f8      	b.n	8000dc4 <charging_send_message+0xa8>
 8000dd2:	482e      	ldr	r0, [pc, #184]	; (8000e8c <charging_send_message+0x170>)
 8000dd4:	2107      	movs	r1, #7
 8000dd6:	f242 7210 	movw	r2, #10000	; 0x2710
 8000dda:	f7ff fefb 	bl	8000bd4 <esp8266_find_stream>
 8000dde:	4604      	mov	r4, r0
 8000de0:	b990      	cbnz	r0, 8000e08 <charging_send_message+0xec>
 8000de2:	4823      	ldr	r0, [pc, #140]	; (8000e70 <charging_send_message+0x154>)
 8000de4:	f7ff fed6 	bl	8000b94 <esp8266_send>
 8000de8:	f44f 70fa 	mov.w	r0, #500	; 0x1f4
 8000dec:	f001 f806 	bl	8001dfc <timer_delay_ms>
 8000df0:	481f      	ldr	r0, [pc, #124]	; (8000e70 <charging_send_message+0x154>)
 8000df2:	f7ff fecf 	bl	8000b94 <esp8266_send>
 8000df6:	f44f 70fa 	mov.w	r0, #500	; 0x1f4
 8000dfa:	f000 ffff 	bl	8001dfc <timer_delay_ms>
 8000dfe:	602c      	str	r4, [r5, #0]
 8000e00:	f06f 0004 	mvn.w	r0, #4
 8000e04:	e8bd 83f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
 8000e08:	4821      	ldr	r0, [pc, #132]	; (8000e90 <charging_send_message+0x174>)
 8000e0a:	2107      	movs	r1, #7
 8000e0c:	f242 7210 	movw	r2, #10000	; 0x2710
 8000e10:	f7ff fee0 	bl	8000bd4 <esp8266_find_stream>
 8000e14:	4604      	mov	r4, r0
 8000e16:	b990      	cbnz	r0, 8000e3e <charging_send_message+0x122>
 8000e18:	4815      	ldr	r0, [pc, #84]	; (8000e70 <charging_send_message+0x154>)
 8000e1a:	f7ff febb 	bl	8000b94 <esp8266_send>
 8000e1e:	f44f 70fa 	mov.w	r0, #500	; 0x1f4
 8000e22:	f000 ffeb 	bl	8001dfc <timer_delay_ms>
 8000e26:	4812      	ldr	r0, [pc, #72]	; (8000e70 <charging_send_message+0x154>)
 8000e28:	f7ff feb4 	bl	8000b94 <esp8266_send>
 8000e2c:	f44f 70fa 	mov.w	r0, #500	; 0x1f4
 8000e30:	f000 ffe4 	bl	8001dfc <timer_delay_ms>
 8000e34:	602c      	str	r4, [r5, #0]
 8000e36:	f06f 0005 	mvn.w	r0, #5
 8000e3a:	e8bd 83f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
 8000e3e:	9909      	ldr	r1, [sp, #36]	; 0x24
 8000e40:	9808      	ldr	r0, [sp, #32]
 8000e42:	220a      	movs	r2, #10
 8000e44:	f7ff ff3f 	bl	8000cc6 <esp8266_get_nonblocking>
 8000e48:	4809      	ldr	r0, [pc, #36]	; (8000e70 <charging_send_message+0x154>)
 8000e4a:	f7ff fea3 	bl	8000b94 <esp8266_send>
 8000e4e:	f44f 70fa 	mov.w	r0, #500	; 0x1f4
 8000e52:	f000 ffd3 	bl	8001dfc <timer_delay_ms>
 8000e56:	4806      	ldr	r0, [pc, #24]	; (8000e70 <charging_send_message+0x154>)
 8000e58:	f7ff fe9c 	bl	8000b94 <esp8266_send>
 8000e5c:	f44f 70fa 	mov.w	r0, #500	; 0x1f4
 8000e60:	f000 ffcc 	bl	8001dfc <timer_delay_ms>
 8000e64:	2000      	movs	r0, #0
 8000e66:	6028      	str	r0, [r5, #0]
 8000e68:	e8bd 83f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
 8000e6c:	20000204 	.word	0x20000204
 8000e70:	08002d20 	.word	0x08002d20
 8000e74:	08002d2e 	.word	0x08002d2e
 8000e78:	08002d42 	.word	0x08002d42
 8000e7c:	08002d09 	.word	0x08002d09
 8000e80:	08002d45 	.word	0x08002d45
 8000e84:	08002d4d 	.word	0x08002d4d
 8000e88:	08002d59 	.word	0x08002d59
 8000e8c:	08002d5b 	.word	0x08002d5b
 8000e90:	08002d63 	.word	0x08002d63

08000e94 <tcp_init>:
 8000e94:	4a0f      	ldr	r2, [pc, #60]	; (8000ed4 <tcp_init+0x40>)
 8000e96:	2300      	movs	r3, #0
 8000e98:	6013      	str	r3, [r2, #0]
 8000e9a:	4611      	mov	r1, r2
 8000e9c:	18c8      	adds	r0, r1, r3
 8000e9e:	3301      	adds	r3, #1
 8000ea0:	2200      	movs	r2, #0
 8000ea2:	2b40      	cmp	r3, #64	; 0x40
 8000ea4:	7102      	strb	r2, [r0, #4]
 8000ea6:	d1f9      	bne.n	8000e9c <tcp_init+0x8>
 8000ea8:	4b0b      	ldr	r3, [pc, #44]	; (8000ed8 <tcp_init+0x44>)
 8000eaa:	490c      	ldr	r1, [pc, #48]	; (8000edc <tcp_init+0x48>)
 8000eac:	6019      	str	r1, [r3, #0]
 8000eae:	490c      	ldr	r1, [pc, #48]	; (8000ee0 <tcp_init+0x4c>)
 8000eb0:	6059      	str	r1, [r3, #4]
 8000eb2:	490c      	ldr	r1, [pc, #48]	; (8000ee4 <tcp_init+0x50>)
 8000eb4:	6099      	str	r1, [r3, #8]
 8000eb6:	4907      	ldr	r1, [pc, #28]	; (8000ed4 <tcp_init+0x40>)
 8000eb8:	60d9      	str	r1, [r3, #12]
 8000eba:	490b      	ldr	r1, [pc, #44]	; (8000ee8 <tcp_init+0x54>)
 8000ebc:	2300      	movs	r3, #0
 8000ebe:	5453      	strb	r3, [r2, r1]
 8000ec0:	3201      	adds	r2, #1
 8000ec2:	2a80      	cmp	r2, #128	; 0x80
 8000ec4:	d1f9      	bne.n	8000eba <tcp_init+0x26>
 8000ec6:	4a09      	ldr	r2, [pc, #36]	; (8000eec <tcp_init+0x58>)
 8000ec8:	2100      	movs	r1, #0
 8000eca:	5499      	strb	r1, [r3, r2]
 8000ecc:	3301      	adds	r3, #1
 8000ece:	2b80      	cmp	r3, #128	; 0x80
 8000ed0:	d1f9      	bne.n	8000ec6 <tcp_init+0x32>
 8000ed2:	4770      	bx	lr
 8000ed4:	20000288 	.word	0x20000288
 8000ed8:	200002cc 	.word	0x200002cc
 8000edc:	20000064 	.word	0x20000064
 8000ee0:	200000ec 	.word	0x200000ec
 8000ee4:	20000034 	.word	0x20000034
 8000ee8:	20000208 	.word	0x20000208
 8000eec:	200002dc 	.word	0x200002dc

08000ef0 <motors_uninit>:
 8000ef0:	b508      	push	{r3, lr}
 8000ef2:	20c2      	movs	r0, #194	; 0xc2
 8000ef4:	2100      	movs	r1, #0
 8000ef6:	2218      	movs	r2, #24
 8000ef8:	f001 fe98 	bl	8002c2c <i2c_write_reg>
 8000efc:	20c6      	movs	r0, #198	; 0xc6
 8000efe:	2100      	movs	r1, #0
 8000f00:	2218      	movs	r2, #24
 8000f02:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 8000f06:	f001 be91 	b.w	8002c2c <i2c_write_reg>
	...

08000f0c <motors_update>:
 8000f0c:	b538      	push	{r3, r4, r5, lr}
 8000f0e:	4b41      	ldr	r3, [pc, #260]	; (8001014 <motors_update+0x108>)
 8000f10:	681c      	ldr	r4, [r3, #0]
 8000f12:	685d      	ldr	r5, [r3, #4]
 8000f14:	b2e4      	uxtb	r4, r4
 8000f16:	b262      	sxtb	r2, r4
 8000f18:	b2ed      	uxtb	r5, r5
 8000f1a:	2a2c      	cmp	r2, #44	; 0x2c
 8000f1c:	b26b      	sxtb	r3, r5
 8000f1e:	dc07      	bgt.n	8000f30 <motors_update+0x24>
 8000f20:	322c      	adds	r2, #44	; 0x2c
 8000f22:	db6e      	blt.n	8001002 <motors_update+0xf6>
 8000f24:	2b2c      	cmp	r3, #44	; 0x2c
 8000f26:	dc5d      	bgt.n	8000fe4 <motors_update+0xd8>
 8000f28:	332c      	adds	r3, #44	; 0x2c
 8000f2a:	db34      	blt.n	8000f96 <motors_update+0x8a>
 8000f2c:	b1e4      	cbz	r4, 8000f68 <motors_update+0x5c>
 8000f2e:	e003      	b.n	8000f38 <motors_update+0x2c>
 8000f30:	242c      	movs	r4, #44	; 0x2c
 8000f32:	42a3      	cmp	r3, r4
 8000f34:	ddf8      	ble.n	8000f28 <motors_update+0x1c>
 8000f36:	4625      	mov	r5, r4
 8000f38:	b263      	sxtb	r3, r4
 8000f3a:	2b00      	cmp	r3, #0
 8000f3c:	dd08      	ble.n	8000f50 <motors_update+0x44>
 8000f3e:	2b05      	cmp	r3, #5
 8000f40:	bfd8      	it	le
 8000f42:	2406      	movle	r4, #6
 8000f44:	b264      	sxtb	r4, r4
 8000f46:	00a4      	lsls	r4, r4, #2
 8000f48:	f044 0402 	orr.w	r4, r4, #2
 8000f4c:	e00a      	b.n	8000f64 <motors_update+0x58>
 8000f4e:	252c      	movs	r5, #44	; 0x2c
 8000f50:	4264      	negs	r4, r4
 8000f52:	b2e4      	uxtb	r4, r4
 8000f54:	2c05      	cmp	r4, #5
 8000f56:	bf8c      	ite	hi
 8000f58:	b2e4      	uxtbhi	r4, r4
 8000f5a:	2406      	movls	r4, #6
 8000f5c:	b264      	sxtb	r4, r4
 8000f5e:	00a4      	lsls	r4, r4, #2
 8000f60:	f044 0401 	orr.w	r4, r4, #1
 8000f64:	b2e4      	uxtb	r4, r4
 8000f66:	e000      	b.n	8000f6a <motors_update+0x5e>
 8000f68:	241b      	movs	r4, #27
 8000f6a:	2100      	movs	r1, #0
 8000f6c:	460a      	mov	r2, r1
 8000f6e:	20c2      	movs	r0, #194	; 0xc2
 8000f70:	f001 fe5c 	bl	8002c2c <i2c_write_reg>
 8000f74:	20c2      	movs	r0, #194	; 0xc2
 8000f76:	2100      	movs	r1, #0
 8000f78:	4622      	mov	r2, r4
 8000f7a:	f001 fe57 	bl	8002c2c <i2c_write_reg>
 8000f7e:	b315      	cbz	r5, 8000fc6 <motors_update+0xba>
 8000f80:	b26b      	sxtb	r3, r5
 8000f82:	2b00      	cmp	r3, #0
 8000f84:	dd13      	ble.n	8000fae <motors_update+0xa2>
 8000f86:	2b05      	cmp	r3, #5
 8000f88:	bfd8      	it	le
 8000f8a:	2506      	movle	r5, #6
 8000f8c:	b26d      	sxtb	r5, r5
 8000f8e:	00ad      	lsls	r5, r5, #2
 8000f90:	f045 0501 	orr.w	r5, r5, #1
 8000f94:	e015      	b.n	8000fc2 <motors_update+0xb6>
 8000f96:	bb1c      	cbnz	r4, 8000fe0 <motors_update+0xd4>
 8000f98:	20c2      	movs	r0, #194	; 0xc2
 8000f9a:	4621      	mov	r1, r4
 8000f9c:	4622      	mov	r2, r4
 8000f9e:	f001 fe45 	bl	8002c2c <i2c_write_reg>
 8000fa2:	20c2      	movs	r0, #194	; 0xc2
 8000fa4:	4621      	mov	r1, r4
 8000fa6:	221b      	movs	r2, #27
 8000fa8:	f001 fe40 	bl	8002c2c <i2c_write_reg>
 8000fac:	25d4      	movs	r5, #212	; 0xd4
 8000fae:	426d      	negs	r5, r5
 8000fb0:	b2ed      	uxtb	r5, r5
 8000fb2:	2d05      	cmp	r5, #5
 8000fb4:	bf8c      	ite	hi
 8000fb6:	b2ed      	uxtbhi	r5, r5
 8000fb8:	2506      	movls	r5, #6
 8000fba:	b26d      	sxtb	r5, r5
 8000fbc:	00ad      	lsls	r5, r5, #2
 8000fbe:	f045 0502 	orr.w	r5, r5, #2
 8000fc2:	b2ed      	uxtb	r5, r5
 8000fc4:	e000      	b.n	8000fc8 <motors_update+0xbc>
 8000fc6:	251b      	movs	r5, #27
 8000fc8:	2100      	movs	r1, #0
 8000fca:	460a      	mov	r2, r1
 8000fcc:	20c6      	movs	r0, #198	; 0xc6
 8000fce:	f001 fe2d 	bl	8002c2c <i2c_write_reg>
 8000fd2:	462a      	mov	r2, r5
 8000fd4:	20c6      	movs	r0, #198	; 0xc6
 8000fd6:	2100      	movs	r1, #0
 8000fd8:	e8bd 4038 	ldmia.w	sp!, {r3, r4, r5, lr}
 8000fdc:	f001 be26 	b.w	8002c2c <i2c_write_reg>
 8000fe0:	25d4      	movs	r5, #212	; 0xd4
 8000fe2:	e7a9      	b.n	8000f38 <motors_update+0x2c>
 8000fe4:	b95c      	cbnz	r4, 8000ffe <motors_update+0xf2>
 8000fe6:	20c2      	movs	r0, #194	; 0xc2
 8000fe8:	4621      	mov	r1, r4
 8000fea:	4622      	mov	r2, r4
 8000fec:	f001 fe1e 	bl	8002c2c <i2c_write_reg>
 8000ff0:	20c2      	movs	r0, #194	; 0xc2
 8000ff2:	4621      	mov	r1, r4
 8000ff4:	221b      	movs	r2, #27
 8000ff6:	f001 fe19 	bl	8002c2c <i2c_write_reg>
 8000ffa:	252c      	movs	r5, #44	; 0x2c
 8000ffc:	e7c6      	b.n	8000f8c <motors_update+0x80>
 8000ffe:	252c      	movs	r5, #44	; 0x2c
 8001000:	e79a      	b.n	8000f38 <motors_update+0x2c>
 8001002:	2b2c      	cmp	r3, #44	; 0x2c
 8001004:	f04f 04d4 	mov.w	r4, #212	; 0xd4
 8001008:	dca1      	bgt.n	8000f4e <motors_update+0x42>
 800100a:	332d      	adds	r3, #45	; 0x2d
 800100c:	bfd8      	it	le
 800100e:	4625      	movle	r5, r4
 8001010:	e792      	b.n	8000f38 <motors_update+0x2c>
 8001012:	bf00      	nop
 8001014:	200000e4 	.word	0x200000e4

08001018 <motors_init>:
 8001018:	b510      	push	{r4, lr}
 800101a:	4b04      	ldr	r3, [pc, #16]	; (800102c <motors_init+0x14>)
 800101c:	2400      	movs	r4, #0
 800101e:	601c      	str	r4, [r3, #0]
 8001020:	605c      	str	r4, [r3, #4]
 8001022:	f7ff ff73 	bl	8000f0c <motors_update>
 8001026:	4620      	mov	r0, r4
 8001028:	bd10      	pop	{r4, pc}
 800102a:	bf00      	nop
 800102c:	200000e4 	.word	0x200000e4

08001030 <thread_ending>:
 8001030:	b672      	cpsid	i
 8001032:	4b05      	ldr	r3, [pc, #20]	; (8001048 <thread_ending+0x18>)
 8001034:	681a      	ldr	r2, [r3, #0]
 8001036:	4b05      	ldr	r3, [pc, #20]	; (800104c <thread_ending+0x1c>)
 8001038:	210c      	movs	r1, #12
 800103a:	fb01 3302 	mla	r3, r1, r2, r3
 800103e:	2200      	movs	r2, #0
 8001040:	605a      	str	r2, [r3, #4]
 8001042:	b662      	cpsie	i
 8001044:	bf00      	nop
 8001046:	e7fd      	b.n	8001044 <thread_ending+0x14>
 8001048:	200003a4 	.word	0x200003a4
 800104c:	2000035c 	.word	0x2000035c

08001050 <null_thread>:
 8001050:	b508      	push	{r3, lr}
 8001052:	f001 fb85 	bl	8002760 <sleep>
 8001056:	e7fc      	b.n	8001052 <null_thread+0x2>

08001058 <scheduler>:
 8001058:	b570      	push	{r4, r5, r6, lr}
 800105a:	2200      	movs	r2, #0
 800105c:	4611      	mov	r1, r2
 800105e:	4b15      	ldr	r3, [pc, #84]	; (80010b4 <scheduler+0x5c>)
 8001060:	200c      	movs	r0, #12
 8001062:	fb00 f401 	mul.w	r4, r0, r1
 8001066:	191e      	adds	r6, r3, r4
 8001068:	6875      	ldr	r5, [r6, #4]
 800106a:	f015 0f02 	tst.w	r5, #2
 800106e:	461d      	mov	r5, r3
 8001070:	d10a      	bne.n	8001088 <scheduler+0x30>
 8001072:	6876      	ldr	r6, [r6, #4]
 8001074:	07f6      	lsls	r6, r6, #31
 8001076:	d507      	bpl.n	8001088 <scheduler+0x30>
 8001078:	4350      	muls	r0, r2
 800107a:	5b1c      	ldrh	r4, [r3, r4]
 800107c:	5a18      	ldrh	r0, [r3, r0]
 800107e:	b2a4      	uxth	r4, r4
 8001080:	b280      	uxth	r0, r0
 8001082:	4284      	cmp	r4, r0
 8001084:	bf38      	it	cc
 8001086:	460a      	movcc	r2, r1
 8001088:	200c      	movs	r0, #12
 800108a:	4348      	muls	r0, r1
 800108c:	5a1c      	ldrh	r4, [r3, r0]
 800108e:	b2a4      	uxth	r4, r4
 8001090:	b11c      	cbz	r4, 800109a <scheduler+0x42>
 8001092:	5a1c      	ldrh	r4, [r3, r0]
 8001094:	3c01      	subs	r4, #1
 8001096:	b2a4      	uxth	r4, r4
 8001098:	521c      	strh	r4, [r3, r0]
 800109a:	3101      	adds	r1, #1
 800109c:	2906      	cmp	r1, #6
 800109e:	d1de      	bne.n	800105e <scheduler+0x6>
 80010a0:	230c      	movs	r3, #12
 80010a2:	4353      	muls	r3, r2
 80010a4:	18e9      	adds	r1, r5, r3
 80010a6:	8849      	ldrh	r1, [r1, #2]
 80010a8:	b289      	uxth	r1, r1
 80010aa:	52e9      	strh	r1, [r5, r3]
 80010ac:	4b02      	ldr	r3, [pc, #8]	; (80010b8 <scheduler+0x60>)
 80010ae:	601a      	str	r2, [r3, #0]
 80010b0:	bd70      	pop	{r4, r5, r6, pc}
 80010b2:	bf00      	nop
 80010b4:	2000035c 	.word	0x2000035c
 80010b8:	200003a4 	.word	0x200003a4

080010bc <SysTick_Handler>:
 80010bc:	e92d 0ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
 80010c0:	f3ef 8308 	mrs	r3, MSP
 80010c4:	4c0d      	ldr	r4, [pc, #52]	; (80010fc <SysTick_Handler+0x40>)
 80010c6:	4d0e      	ldr	r5, [pc, #56]	; (8001100 <SysTick_Handler+0x44>)
 80010c8:	6822      	ldr	r2, [r4, #0]
 80010ca:	3201      	adds	r2, #1
 80010cc:	bf1d      	ittte	ne
 80010ce:	6822      	ldrne	r2, [r4, #0]
 80010d0:	210c      	movne	r1, #12
 80010d2:	fb01 5202 	mlane	r2, r1, r2, r5
 80010d6:	2300      	moveq	r3, #0
 80010d8:	bf14      	ite	ne
 80010da:	6093      	strne	r3, [r2, #8]
 80010dc:	6023      	streq	r3, [r4, #0]
 80010de:	f7ff ffbb 	bl	8001058 <scheduler>
 80010e2:	6822      	ldr	r2, [r4, #0]
 80010e4:	230c      	movs	r3, #12
 80010e6:	fb03 5302 	mla	r3, r3, r2, r5
 80010ea:	689a      	ldr	r2, [r3, #8]
 80010ec:	f06f 0306 	mvn.w	r3, #6
 80010f0:	469e      	mov	lr, r3
 80010f2:	f382 8808 	msr	MSP, r2
 80010f6:	e8bd 0ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
 80010fa:	4770      	bx	lr
 80010fc:	200003a4 	.word	0x200003a4
 8001100:	2000035c 	.word	0x2000035c

08001104 <sched_off>:
 8001104:	b672      	cpsid	i
 8001106:	4770      	bx	lr

08001108 <sched_on>:
 8001108:	b662      	cpsie	i
 800110a:	4770      	bx	lr

0800110c <yield>:
 800110c:	bf00      	nop
 800110e:	4770      	bx	lr

08001110 <get_thread_id>:
 8001110:	b082      	sub	sp, #8
 8001112:	b672      	cpsid	i
 8001114:	4b03      	ldr	r3, [pc, #12]	; (8001124 <get_thread_id+0x14>)
 8001116:	681b      	ldr	r3, [r3, #0]
 8001118:	9301      	str	r3, [sp, #4]
 800111a:	b662      	cpsie	i
 800111c:	9801      	ldr	r0, [sp, #4]
 800111e:	b002      	add	sp, #8
 8001120:	4770      	bx	lr
 8001122:	bf00      	nop
 8001124:	200003a4 	.word	0x200003a4

08001128 <kernel_start>:
 8001128:	b508      	push	{r3, lr}
 800112a:	f001 fb07 	bl	800273c <sys_tick_init>
 800112e:	bf00      	nop
 8001130:	e7fd      	b.n	800112e <kernel_start+0x6>
	...

08001134 <create_thread>:
 8001134:	f022 0203 	bic.w	r2, r2, #3
 8001138:	3a40      	subs	r2, #64	; 0x40
 800113a:	e92d 41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
 800113e:	eb01 0e02 	add.w	lr, r1, r2
 8001142:	f102 0634 	add.w	r6, r2, #52	; 0x34
 8001146:	f102 0738 	add.w	r7, r2, #56	; 0x38
 800114a:	323c      	adds	r2, #60	; 0x3c
 800114c:	440e      	add	r6, r1
 800114e:	440f      	add	r7, r1
 8001150:	4411      	add	r1, r2
 8001152:	2200      	movs	r2, #0
 8001154:	b672      	cpsid	i
 8001156:	f8df c054 	ldr.w	ip, [pc, #84]	; 80011ac <create_thread+0x78>
 800115a:	250c      	movs	r5, #12
 800115c:	4355      	muls	r5, r2
 800115e:	eb0c 0405 	add.w	r4, ip, r5
 8001162:	f8d4 8004 	ldr.w	r8, [r4, #4]
 8001166:	f018 0f01 	tst.w	r8, #1
 800116a:	d114      	bne.n	8001196 <create_thread+0x62>
 800116c:	f8df 8040 	ldr.w	r8, [pc, #64]	; 80011b0 <create_thread+0x7c>
 8001170:	f8c4 e008 	str.w	lr, [r4, #8]
 8001174:	2b05      	cmp	r3, #5
 8001176:	f8c6 8000 	str.w	r8, [r6]
 800117a:	bf98      	it	ls
 800117c:	2306      	movls	r3, #6
 800117e:	f04f 5804 	mov.w	r8, #553648128	; 0x21000000
 8001182:	6038      	str	r0, [r7, #0]
 8001184:	f8c1 8000 	str.w	r8, [r1]
 8001188:	8063      	strh	r3, [r4, #2]
 800118a:	f82c 3005 	strh.w	r3, [ip, r5]
 800118e:	2501      	movs	r5, #1
 8001190:	6065      	str	r5, [r4, #4]
 8001192:	4614      	mov	r4, r2
 8001194:	e000      	b.n	8001198 <create_thread+0x64>
 8001196:	2406      	movs	r4, #6
 8001198:	b662      	cpsie	i
 800119a:	3201      	adds	r2, #1
 800119c:	2a06      	cmp	r2, #6
 800119e:	d001      	beq.n	80011a4 <create_thread+0x70>
 80011a0:	2c06      	cmp	r4, #6
 80011a2:	d0d7      	beq.n	8001154 <create_thread+0x20>
 80011a4:	4620      	mov	r0, r4
 80011a6:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
 80011aa:	bf00      	nop
 80011ac:	2000035c 	.word	0x2000035c
 80011b0:	08001031 	.word	0x08001031

080011b4 <kernel_init>:
 80011b4:	b510      	push	{r4, lr}
 80011b6:	2300      	movs	r3, #0
 80011b8:	490b      	ldr	r1, [pc, #44]	; (80011e8 <kernel_init+0x34>)
 80011ba:	220c      	movs	r2, #12
 80011bc:	435a      	muls	r2, r3
 80011be:	188c      	adds	r4, r1, r2
 80011c0:	2000      	movs	r0, #0
 80011c2:	6060      	str	r0, [r4, #4]
 80011c4:	3301      	adds	r3, #1
 80011c6:	2006      	movs	r0, #6
 80011c8:	4283      	cmp	r3, r0
 80011ca:	8060      	strh	r0, [r4, #2]
 80011cc:	5288      	strh	r0, [r1, r2]
 80011ce:	d1f3      	bne.n	80011b8 <kernel_init+0x4>
 80011d0:	4b06      	ldr	r3, [pc, #24]	; (80011ec <kernel_init+0x38>)
 80011d2:	4807      	ldr	r0, [pc, #28]	; (80011f0 <kernel_init+0x3c>)
 80011d4:	4907      	ldr	r1, [pc, #28]	; (80011f4 <kernel_init+0x40>)
 80011d6:	f04f 32ff 	mov.w	r2, #4294967295	; 0xffffffff
 80011da:	601a      	str	r2, [r3, #0]
 80011dc:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
 80011e0:	2280      	movs	r2, #128	; 0x80
 80011e2:	23ff      	movs	r3, #255	; 0xff
 80011e4:	f7ff bfa6 	b.w	8001134 <create_thread>
 80011e8:	2000035c 	.word	0x2000035c
 80011ec:	200003a4 	.word	0x200003a4
 80011f0:	08001051 	.word	0x08001051
 80011f4:	200003a8 	.word	0x200003a8

080011f8 <set_wait_state>:
 80011f8:	b507      	push	{r0, r1, r2, lr}
 80011fa:	f7ff ff89 	bl	8001110 <get_thread_id>
 80011fe:	9000      	str	r0, [sp, #0]
 8001200:	b672      	cpsid	i
 8001202:	4b0d      	ldr	r3, [pc, #52]	; (8001238 <set_wait_state+0x40>)
 8001204:	9a00      	ldr	r2, [sp, #0]
 8001206:	210c      	movs	r1, #12
 8001208:	fb01 3202 	mla	r2, r1, r2, r3
 800120c:	6851      	ldr	r1, [r2, #4]
 800120e:	f041 0102 	orr.w	r1, r1, #2
 8001212:	6051      	str	r1, [r2, #4]
 8001214:	b672      	cpsid	i
 8001216:	9a00      	ldr	r2, [sp, #0]
 8001218:	210c      	movs	r1, #12
 800121a:	fb01 3202 	mla	r2, r1, r2, r3
 800121e:	6852      	ldr	r2, [r2, #4]
 8001220:	9201      	str	r2, [sp, #4]
 8001222:	b662      	cpsie	i
 8001224:	9a01      	ldr	r2, [sp, #4]
 8001226:	0791      	lsls	r1, r2, #30
 8001228:	d500      	bpl.n	800122c <set_wait_state+0x34>
 800122a:	bf00      	nop
 800122c:	9a01      	ldr	r2, [sp, #4]
 800122e:	0792      	lsls	r2, r2, #30
 8001230:	d4f0      	bmi.n	8001214 <set_wait_state+0x1c>
 8001232:	b003      	add	sp, #12
 8001234:	f85d fb04 	ldr.w	pc, [sp], #4
 8001238:	2000035c 	.word	0x2000035c

0800123c <wake_up_threads>:
 800123c:	2300      	movs	r3, #0
 800123e:	b672      	cpsid	i
 8001240:	4906      	ldr	r1, [pc, #24]	; (800125c <wake_up_threads+0x20>)
 8001242:	220c      	movs	r2, #12
 8001244:	fb02 1203 	mla	r2, r2, r3, r1
 8001248:	6851      	ldr	r1, [r2, #4]
 800124a:	f021 0102 	bic.w	r1, r1, #2
 800124e:	6051      	str	r1, [r2, #4]
 8001250:	b662      	cpsie	i
 8001252:	3301      	adds	r3, #1
 8001254:	2b06      	cmp	r3, #6
 8001256:	d1f2      	bne.n	800123e <wake_up_threads+0x2>
 8001258:	4770      	bx	lr
 800125a:	bf00      	nop
 800125c:	2000035c 	.word	0x2000035c

08001260 <putc_>:
 8001260:	b538      	push	{r3, r4, r5, lr}
 8001262:	4c06      	ldr	r4, [pc, #24]	; (800127c <putc_+0x1c>)
 8001264:	4605      	mov	r5, r0
 8001266:	4620      	mov	r0, r4
 8001268:	f000 f8f8 	bl	800145c <mutex_lock>
 800126c:	4628      	mov	r0, r5
 800126e:	f001 f96b 	bl	8002548 <uart_write>
 8001272:	4620      	mov	r0, r4
 8001274:	e8bd 4038 	ldmia.w	sp!, {r3, r4, r5, lr}
 8001278:	f000 b90c 	b.w	8001494 <mutex_unlock>
 800127c:	20000428 	.word	0x20000428

08001280 <puts_>:
 8001280:	b510      	push	{r4, lr}
 8001282:	4604      	mov	r4, r0
 8001284:	4807      	ldr	r0, [pc, #28]	; (80012a4 <puts_+0x24>)
 8001286:	f000 f8e9 	bl	800145c <mutex_lock>
 800128a:	3c01      	subs	r4, #1
 800128c:	f814 0f01 	ldrb.w	r0, [r4, #1]!
 8001290:	b110      	cbz	r0, 8001298 <puts_+0x18>
 8001292:	f7ff ffe5 	bl	8001260 <putc_>
 8001296:	e7f9      	b.n	800128c <puts_+0xc>
 8001298:	4802      	ldr	r0, [pc, #8]	; (80012a4 <puts_+0x24>)
 800129a:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
 800129e:	f000 b8f9 	b.w	8001494 <mutex_unlock>
 80012a2:	bf00      	nop
 80012a4:	20000434 	.word	0x20000434

080012a8 <puti_>:
 80012a8:	b530      	push	{r4, r5, lr}
 80012aa:	b085      	sub	sp, #20
 80012ac:	1e03      	subs	r3, r0, #0
 80012ae:	f04f 0200 	mov.w	r2, #0
 80012b2:	bfba      	itte	lt
 80012b4:	425b      	neglt	r3, r3
 80012b6:	2401      	movlt	r4, #1
 80012b8:	4614      	movge	r4, r2
 80012ba:	f88d 200f 	strb.w	r2, [sp, #15]
 80012be:	210a      	movs	r1, #10
 80012c0:	220a      	movs	r2, #10
 80012c2:	a801      	add	r0, sp, #4
 80012c4:	fb93 f5f2 	sdiv	r5, r3, r2
 80012c8:	fb02 3315 	mls	r3, r2, r5, r3
 80012cc:	3330      	adds	r3, #48	; 0x30
 80012ce:	540b      	strb	r3, [r1, r0]
 80012d0:	1e4a      	subs	r2, r1, #1
 80012d2:	462b      	mov	r3, r5
 80012d4:	b10d      	cbz	r5, 80012da <puti_+0x32>
 80012d6:	4611      	mov	r1, r2
 80012d8:	e7f2      	b.n	80012c0 <puti_+0x18>
 80012da:	b12c      	cbz	r4, 80012e8 <puti_+0x40>
 80012dc:	ab04      	add	r3, sp, #16
 80012de:	4413      	add	r3, r2
 80012e0:	212d      	movs	r1, #45	; 0x2d
 80012e2:	f803 1c0c 	strb.w	r1, [r3, #-12]
 80012e6:	4611      	mov	r1, r2
 80012e8:	4408      	add	r0, r1
 80012ea:	f7ff ffc9 	bl	8001280 <puts_>
 80012ee:	b005      	add	sp, #20
 80012f0:	bd30      	pop	{r4, r5, pc}

080012f2 <putui_>:
 80012f2:	b51f      	push	{r0, r1, r2, r3, r4, lr}
 80012f4:	2300      	movs	r3, #0
 80012f6:	f88d 300f 	strb.w	r3, [sp, #15]
 80012fa:	220a      	movs	r2, #10
 80012fc:	230a      	movs	r3, #10
 80012fe:	a901      	add	r1, sp, #4
 8001300:	fbb0 f4f3 	udiv	r4, r0, r3
 8001304:	fb03 0314 	mls	r3, r3, r4, r0
 8001308:	3330      	adds	r3, #48	; 0x30
 800130a:	5453      	strb	r3, [r2, r1]
 800130c:	4620      	mov	r0, r4
 800130e:	1e53      	subs	r3, r2, #1
 8001310:	b10c      	cbz	r4, 8001316 <putui_+0x24>
 8001312:	461a      	mov	r2, r3
 8001314:	e7f2      	b.n	80012fc <putui_+0xa>
 8001316:	1888      	adds	r0, r1, r2
 8001318:	f7ff ffb2 	bl	8001280 <puts_>
 800131c:	b004      	add	sp, #16
 800131e:	bd10      	pop	{r4, pc}

08001320 <putx_>:
 8001320:	b51f      	push	{r0, r1, r2, r3, r4, lr}
 8001322:	2300      	movs	r3, #0
 8001324:	f88d 300f 	strb.w	r3, [sp, #15]
 8001328:	220a      	movs	r2, #10
 800132a:	f000 030f 	and.w	r3, r0, #15
 800132e:	2b09      	cmp	r3, #9
 8001330:	a901      	add	r1, sp, #4
 8001332:	bf94      	ite	ls
 8001334:	3330      	addls	r3, #48	; 0x30
 8001336:	3357      	addhi	r3, #87	; 0x57
 8001338:	0900      	lsrs	r0, r0, #4
 800133a:	548b      	strb	r3, [r1, r2]
 800133c:	f102 33ff 	add.w	r3, r2, #4294967295	; 0xffffffff
 8001340:	d001      	beq.n	8001346 <putx_+0x26>
 8001342:	461a      	mov	r2, r3
 8001344:	e7f1      	b.n	800132a <putx_+0xa>
 8001346:	1888      	adds	r0, r1, r2
 8001348:	f7ff ff9a 	bl	8001280 <puts_>
 800134c:	b005      	add	sp, #20
 800134e:	f85d fb04 	ldr.w	pc, [sp], #4
	...

08001354 <printf_>:
 8001354:	b40f      	push	{r0, r1, r2, r3}
 8001356:	b537      	push	{r0, r1, r2, r4, r5, lr}
 8001358:	ac06      	add	r4, sp, #24
 800135a:	4826      	ldr	r0, [pc, #152]	; (80013f4 <printf_+0xa0>)
 800135c:	f854 5b04 	ldr.w	r5, [r4], #4
 8001360:	f000 f87c 	bl	800145c <mutex_lock>
 8001364:	9401      	str	r4, [sp, #4]
 8001366:	2400      	movs	r4, #0
 8001368:	5d28      	ldrb	r0, [r5, r4]
 800136a:	2800      	cmp	r0, #0
 800136c:	d039      	beq.n	80013e2 <printf_+0x8e>
 800136e:	2825      	cmp	r0, #37	; 0x25
 8001370:	d003      	beq.n	800137a <printf_+0x26>
 8001372:	f7ff ff75 	bl	8001260 <putc_>
 8001376:	3401      	adds	r4, #1
 8001378:	e7f6      	b.n	8001368 <printf_+0x14>
 800137a:	192b      	adds	r3, r5, r4
 800137c:	7858      	ldrb	r0, [r3, #1]
 800137e:	2869      	cmp	r0, #105	; 0x69
 8001380:	d016      	beq.n	80013b0 <printf_+0x5c>
 8001382:	d808      	bhi.n	8001396 <printf_+0x42>
 8001384:	2825      	cmp	r0, #37	; 0x25
 8001386:	d028      	beq.n	80013da <printf_+0x86>
 8001388:	2863      	cmp	r0, #99	; 0x63
 800138a:	d128      	bne.n	80013de <printf_+0x8a>
 800138c:	9b01      	ldr	r3, [sp, #4]
 800138e:	1d1a      	adds	r2, r3, #4
 8001390:	9201      	str	r2, [sp, #4]
 8001392:	7818      	ldrb	r0, [r3, #0]
 8001394:	e021      	b.n	80013da <printf_+0x86>
 8001396:	2875      	cmp	r0, #117	; 0x75
 8001398:	d011      	beq.n	80013be <printf_+0x6a>
 800139a:	2878      	cmp	r0, #120	; 0x78
 800139c:	d016      	beq.n	80013cc <printf_+0x78>
 800139e:	2873      	cmp	r0, #115	; 0x73
 80013a0:	d11d      	bne.n	80013de <printf_+0x8a>
 80013a2:	9b01      	ldr	r3, [sp, #4]
 80013a4:	1d1a      	adds	r2, r3, #4
 80013a6:	6818      	ldr	r0, [r3, #0]
 80013a8:	9201      	str	r2, [sp, #4]
 80013aa:	f7ff ff69 	bl	8001280 <puts_>
 80013ae:	e016      	b.n	80013de <printf_+0x8a>
 80013b0:	9b01      	ldr	r3, [sp, #4]
 80013b2:	1d1a      	adds	r2, r3, #4
 80013b4:	6818      	ldr	r0, [r3, #0]
 80013b6:	9201      	str	r2, [sp, #4]
 80013b8:	f7ff ff76 	bl	80012a8 <puti_>
 80013bc:	e00f      	b.n	80013de <printf_+0x8a>
 80013be:	9b01      	ldr	r3, [sp, #4]
 80013c0:	1d1a      	adds	r2, r3, #4
 80013c2:	6818      	ldr	r0, [r3, #0]
 80013c4:	9201      	str	r2, [sp, #4]
 80013c6:	f7ff ff94 	bl	80012f2 <putui_>
 80013ca:	e008      	b.n	80013de <printf_+0x8a>
 80013cc:	9b01      	ldr	r3, [sp, #4]
 80013ce:	1d1a      	adds	r2, r3, #4
 80013d0:	6818      	ldr	r0, [r3, #0]
 80013d2:	9201      	str	r2, [sp, #4]
 80013d4:	f7ff ffa4 	bl	8001320 <putx_>
 80013d8:	e001      	b.n	80013de <printf_+0x8a>
 80013da:	f7ff ff41 	bl	8001260 <putc_>
 80013de:	3402      	adds	r4, #2
 80013e0:	e7c2      	b.n	8001368 <printf_+0x14>
 80013e2:	4804      	ldr	r0, [pc, #16]	; (80013f4 <printf_+0xa0>)
 80013e4:	f000 f856 	bl	8001494 <mutex_unlock>
 80013e8:	b003      	add	sp, #12
 80013ea:	e8bd 4030 	ldmia.w	sp!, {r4, r5, lr}
 80013ee:	b004      	add	sp, #16
 80013f0:	4770      	bx	lr
 80013f2:	bf00      	nop
 80013f4:	20000430 	.word	0x20000430

080013f8 <stdio_init>:
 80013f8:	b510      	push	{r4, lr}
 80013fa:	480e      	ldr	r0, [pc, #56]	; (8001434 <stdio_init+0x3c>)
 80013fc:	f000 f824 	bl	8001448 <mutex_init>
 8001400:	480d      	ldr	r0, [pc, #52]	; (8001438 <stdio_init+0x40>)
 8001402:	f000 f821 	bl	8001448 <mutex_init>
 8001406:	480d      	ldr	r0, [pc, #52]	; (800143c <stdio_init+0x44>)
 8001408:	f000 f81e 	bl	8001448 <mutex_init>
 800140c:	480c      	ldr	r0, [pc, #48]	; (8001440 <stdio_init+0x48>)
 800140e:	f000 f81b 	bl	8001448 <mutex_init>
 8001412:	2408      	movs	r4, #8
 8001414:	2020      	movs	r0, #32
 8001416:	f7ff ff23 	bl	8001260 <putc_>
 800141a:	3c01      	subs	r4, #1
 800141c:	d1fa      	bne.n	8001414 <stdio_init+0x1c>
 800141e:	2420      	movs	r4, #32
 8001420:	200a      	movs	r0, #10
 8001422:	f7ff ff1d 	bl	8001260 <putc_>
 8001426:	3c01      	subs	r4, #1
 8001428:	d1fa      	bne.n	8001420 <stdio_init+0x28>
 800142a:	4806      	ldr	r0, [pc, #24]	; (8001444 <stdio_init+0x4c>)
 800142c:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
 8001430:	f7ff bf90 	b.w	8001354 <printf_>
 8001434:	20000428 	.word	0x20000428
 8001438:	2000042c 	.word	0x2000042c
 800143c:	20000434 	.word	0x20000434
 8001440:	20000430 	.word	0x20000430
 8001444:	08002d80 	.word	0x08002d80

08001448 <mutex_init>:
 8001448:	b510      	push	{r4, lr}
 800144a:	4604      	mov	r4, r0
 800144c:	f7ff fe5a 	bl	8001104 <sched_off>
 8001450:	2300      	movs	r3, #0
 8001452:	6023      	str	r3, [r4, #0]
 8001454:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
 8001458:	f7ff be56 	b.w	8001108 <sched_on>

0800145c <mutex_lock>:
 800145c:	b513      	push	{r0, r1, r4, lr}
 800145e:	4604      	mov	r4, r0
 8001460:	f7ff fe50 	bl	8001104 <sched_off>
 8001464:	6823      	ldr	r3, [r4, #0]
 8001466:	9301      	str	r3, [sp, #4]
 8001468:	f7ff fe4e 	bl	8001108 <sched_on>
 800146c:	9b01      	ldr	r3, [sp, #4]
 800146e:	b10b      	cbz	r3, 8001474 <mutex_lock+0x18>
 8001470:	f7ff fec2 	bl	80011f8 <set_wait_state>
 8001474:	9b01      	ldr	r3, [sp, #4]
 8001476:	2b00      	cmp	r3, #0
 8001478:	d1f2      	bne.n	8001460 <mutex_lock+0x4>
 800147a:	f7ff fe43 	bl	8001104 <sched_off>
 800147e:	6823      	ldr	r3, [r4, #0]
 8001480:	9301      	str	r3, [sp, #4]
 8001482:	9b01      	ldr	r3, [sp, #4]
 8001484:	2b00      	cmp	r3, #0
 8001486:	d1eb      	bne.n	8001460 <mutex_lock+0x4>
 8001488:	2301      	movs	r3, #1
 800148a:	6023      	str	r3, [r4, #0]
 800148c:	f7ff fe3c 	bl	8001108 <sched_on>
 8001490:	b002      	add	sp, #8
 8001492:	bd10      	pop	{r4, pc}

08001494 <mutex_unlock>:
 8001494:	b508      	push	{r3, lr}
 8001496:	f7ff ffd7 	bl	8001448 <mutex_init>
 800149a:	f7ff fecf 	bl	800123c <wake_up_threads>
 800149e:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 80014a2:	f7ff be33 	b.w	800110c <yield>
	...

080014a8 <messages_init>:
 80014a8:	4a0a      	ldr	r2, [pc, #40]	; (80014d4 <messages_init+0x2c>)
 80014aa:	2300      	movs	r3, #0
 80014ac:	b510      	push	{r4, lr}
 80014ae:	6013      	str	r3, [r2, #0]
 80014b0:	6053      	str	r3, [r2, #4]
 80014b2:	6093      	str	r3, [r2, #8]
 80014b4:	60d3      	str	r3, [r2, #12]
 80014b6:	6113      	str	r3, [r2, #16]
 80014b8:	6153      	str	r3, [r2, #20]
 80014ba:	4c07      	ldr	r4, [pc, #28]	; (80014d8 <messages_init+0x30>)
 80014bc:	0118      	lsls	r0, r3, #4
 80014be:	1821      	adds	r1, r4, r0
 80014c0:	3301      	adds	r3, #1
 80014c2:	2200      	movs	r2, #0
 80014c4:	2b04      	cmp	r3, #4
 80014c6:	604a      	str	r2, [r1, #4]
 80014c8:	5022      	str	r2, [r4, r0]
 80014ca:	60ca      	str	r2, [r1, #12]
 80014cc:	608a      	str	r2, [r1, #8]
 80014ce:	d1f4      	bne.n	80014ba <messages_init+0x12>
 80014d0:	bd10      	pop	{r4, pc}
 80014d2:	bf00      	nop
 80014d4:	20000438 	.word	0x20000438
 80014d8:	20000450 	.word	0x20000450

080014dc <lib_os_init>:
 80014dc:	b508      	push	{r3, lr}
 80014de:	f7ff fe69 	bl	80011b4 <kernel_init>
 80014e2:	f7ff ffe1 	bl	80014a8 <messages_init>
 80014e6:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 80014ea:	f7ff bf85 	b.w	80013f8 <stdio_init>
	...

080014f0 <main>:
 80014f0:	b508      	push	{r3, lr}
 80014f2:	f000 fb4f 	bl	8001b94 <lib_low_level_init>
 80014f6:	f7ff fff1 	bl	80014dc <lib_os_init>
 80014fa:	4905      	ldr	r1, [pc, #20]	; (8001510 <main+0x20>)
 80014fc:	4805      	ldr	r0, [pc, #20]	; (8001514 <main+0x24>)
 80014fe:	f44f 7200 	mov.w	r2, #512	; 0x200
 8001502:	2306      	movs	r3, #6
 8001504:	f7ff fe16 	bl	8001134 <create_thread>
 8001508:	f7ff fe0e 	bl	8001128 <kernel_start>
 800150c:	2000      	movs	r0, #0
 800150e:	bd08      	pop	{r3, pc}
 8001510:	20000a90 	.word	0x20000a90
 8001514:	08001ad1 	.word	0x08001ad1

08001518 <abort_error_>:
 8001518:	b570      	push	{r4, r5, r6, lr}
 800151a:	4605      	mov	r5, r0
 800151c:	460e      	mov	r6, r1
 800151e:	480d      	ldr	r0, [pc, #52]	; (8001554 <abort_error_+0x3c>)
 8001520:	4629      	mov	r1, r5
 8001522:	4632      	mov	r2, r6
 8001524:	f7ff ff16 	bl	8001354 <printf_>
 8001528:	2408      	movs	r4, #8
 800152a:	f44f 4000 	mov.w	r0, #32768	; 0x8000
 800152e:	f001 f999 	bl	8002864 <led_on>
 8001532:	201e      	movs	r0, #30
 8001534:	f000 fc62 	bl	8001dfc <timer_delay_ms>
 8001538:	f44f 4000 	mov.w	r0, #32768	; 0x8000
 800153c:	f001 f9a8 	bl	8002890 <led_off>
 8001540:	2046      	movs	r0, #70	; 0x46
 8001542:	f000 fc5b 	bl	8001dfc <timer_delay_ms>
 8001546:	3c01      	subs	r4, #1
 8001548:	d1ef      	bne.n	800152a <abort_error_+0x12>
 800154a:	f44f 707a 	mov.w	r0, #1000	; 0x3e8
 800154e:	f000 fc55 	bl	8001dfc <timer_delay_ms>
 8001552:	e7e4      	b.n	800151e <abort_error_+0x6>
 8001554:	08002d91 	.word	0x08002d91

08001558 <charging_test_go_straight_until_line>:
 8001558:	b570      	push	{r4, r5, r6, lr}
 800155a:	4606      	mov	r6, r0
 800155c:	f7ff f9f8 	bl	8000950 <rgb_get_line_position>
 8001560:	4b11      	ldr	r3, [pc, #68]	; (80015a8 <charging_test_go_straight_until_line+0x50>)
 8001562:	220a      	movs	r2, #10
 8001564:	605a      	str	r2, [r3, #4]
 8001566:	461d      	mov	r5, r3
 8001568:	601a      	str	r2, [r3, #0]
 800156a:	2e03      	cmp	r6, #3
 800156c:	d812      	bhi.n	8001594 <charging_test_go_straight_until_line+0x3c>
 800156e:	e8df f006 	tbb	[pc, r6]
 8001572:	0502      	.short	0x0502
 8001574:	0b08      	.short	0x0b08
 8001576:	4b0d      	ldr	r3, [pc, #52]	; (80015ac <charging_test_go_straight_until_line+0x54>)
 8001578:	7c1c      	ldrb	r4, [r3, #16]
 800157a:	e007      	b.n	800158c <charging_test_go_straight_until_line+0x34>
 800157c:	4b0b      	ldr	r3, [pc, #44]	; (80015ac <charging_test_go_straight_until_line+0x54>)
 800157e:	7c5c      	ldrb	r4, [r3, #17]
 8001580:	e004      	b.n	800158c <charging_test_go_straight_until_line+0x34>
 8001582:	4b0a      	ldr	r3, [pc, #40]	; (80015ac <charging_test_go_straight_until_line+0x54>)
 8001584:	7c9c      	ldrb	r4, [r3, #18]
 8001586:	e001      	b.n	800158c <charging_test_go_straight_until_line+0x34>
 8001588:	4b08      	ldr	r3, [pc, #32]	; (80015ac <charging_test_go_straight_until_line+0x54>)
 800158a:	7cdc      	ldrb	r4, [r3, #19]
 800158c:	fab4 f484 	clz	r4, r4
 8001590:	0964      	lsrs	r4, r4, #5
 8001592:	e000      	b.n	8001596 <charging_test_go_straight_until_line+0x3e>
 8001594:	2401      	movs	r4, #1
 8001596:	200a      	movs	r0, #10
 8001598:	f000 fc30 	bl	8001dfc <timer_delay_ms>
 800159c:	2c00      	cmp	r4, #0
 800159e:	d1dd      	bne.n	800155c <charging_test_go_straight_until_line+0x4>
 80015a0:	606c      	str	r4, [r5, #4]
 80015a2:	602c      	str	r4, [r5, #0]
 80015a4:	bd70      	pop	{r4, r5, r6, pc}
 80015a6:	bf00      	nop
 80015a8:	200000e4 	.word	0x200000e4
 80015ac:	200000ec 	.word	0x200000ec

080015b0 <slightTurn>:
 80015b0:	2a02      	cmp	r2, #2
 80015b2:	b510      	push	{r4, lr}
 80015b4:	d105      	bne.n	80015c2 <slightTurn+0x12>
 80015b6:	4c0a      	ldr	r4, [pc, #40]	; (80015e0 <slightTurn+0x30>)
 80015b8:	6021      	str	r1, [r4, #0]
 80015ba:	fb91 f1f2 	sdiv	r1, r1, r2
 80015be:	4249      	negs	r1, r1
 80015c0:	e007      	b.n	80015d2 <slightTurn+0x22>
 80015c2:	2a01      	cmp	r2, #1
 80015c4:	d10b      	bne.n	80015de <slightTurn+0x2e>
 80015c6:	4c06      	ldr	r4, [pc, #24]	; (80015e0 <slightTurn+0x30>)
 80015c8:	2302      	movs	r3, #2
 80015ca:	fb91 f3f3 	sdiv	r3, r1, r3
 80015ce:	425b      	negs	r3, r3
 80015d0:	6023      	str	r3, [r4, #0]
 80015d2:	6061      	str	r1, [r4, #4]
 80015d4:	f000 fc12 	bl	8001dfc <timer_delay_ms>
 80015d8:	2300      	movs	r3, #0
 80015da:	6023      	str	r3, [r4, #0]
 80015dc:	6063      	str	r3, [r4, #4]
 80015de:	bd10      	pop	{r4, pc}
 80015e0:	200000e4 	.word	0x200000e4

080015e4 <line_follower_until_color>:
 80015e4:	b570      	push	{r4, r5, r6, lr}
 80015e6:	ed2d 8b06 	vpush	{d8-d10}
 80015ea:	eddf 8a46 	vldr	s17, [pc, #280]	; 8001704 <line_follower_until_color+0x120>
 80015ee:	4604      	mov	r4, r0
 80015f0:	460d      	mov	r5, r1
 80015f2:	eef0 9a68 	vmov.f32	s19, s17
 80015f6:	eeb0 aa68 	vmov.f32	s20, s17
 80015fa:	f7ff f9a9 	bl	8000950 <rgb_get_line_position>
 80015fe:	4e42      	ldr	r6, [pc, #264]	; (8001708 <line_follower_until_color+0x124>)
 8001600:	2d03      	cmp	r5, #3
 8001602:	d817      	bhi.n	8001634 <line_follower_until_color+0x50>
 8001604:	e8df f005 	tbb	[pc, r5]
 8001608:	0b080502 	.word	0x0b080502
 800160c:	4b3f      	ldr	r3, [pc, #252]	; (800170c <line_follower_until_color+0x128>)
 800160e:	7c1b      	ldrb	r3, [r3, #16]
 8001610:	e007      	b.n	8001622 <line_follower_until_color+0x3e>
 8001612:	4b3e      	ldr	r3, [pc, #248]	; (800170c <line_follower_until_color+0x128>)
 8001614:	7c5b      	ldrb	r3, [r3, #17]
 8001616:	e004      	b.n	8001622 <line_follower_until_color+0x3e>
 8001618:	4b3c      	ldr	r3, [pc, #240]	; (800170c <line_follower_until_color+0x128>)
 800161a:	7c9b      	ldrb	r3, [r3, #18]
 800161c:	e001      	b.n	8001622 <line_follower_until_color+0x3e>
 800161e:	4b3b      	ldr	r3, [pc, #236]	; (800170c <line_follower_until_color+0x128>)
 8001620:	7cdb      	ldrb	r3, [r3, #19]
 8001622:	fab3 f383 	clz	r3, r3
 8001626:	095b      	lsrs	r3, r3, #5
 8001628:	b923      	cbnz	r3, 8001634 <line_follower_until_color+0x50>
 800162a:	ecbd 8b06 	vpop	{d8-d10}
 800162e:	6033      	str	r3, [r6, #0]
 8001630:	6073      	str	r3, [r6, #4]
 8001632:	bd70      	pop	{r4, r5, r6, pc}
 8001634:	2c03      	cmp	r4, #3
 8001636:	d81b      	bhi.n	8001670 <line_follower_until_color+0x8c>
 8001638:	e8df f004 	tbb	[pc, r4]
 800163c:	0e0a0602 	.word	0x0e0a0602
 8001640:	4b32      	ldr	r3, [pc, #200]	; (800170c <line_follower_until_color+0x128>)
 8001642:	ed93 8a00 	vldr	s16, [r3]
 8001646:	e00a      	b.n	800165e <line_follower_until_color+0x7a>
 8001648:	4b30      	ldr	r3, [pc, #192]	; (800170c <line_follower_until_color+0x128>)
 800164a:	ed93 8a01 	vldr	s16, [r3, #4]
 800164e:	e006      	b.n	800165e <line_follower_until_color+0x7a>
 8001650:	4b2e      	ldr	r3, [pc, #184]	; (800170c <line_follower_until_color+0x128>)
 8001652:	ed93 8a02 	vldr	s16, [r3, #8]
 8001656:	e002      	b.n	800165e <line_follower_until_color+0x7a>
 8001658:	4b2c      	ldr	r3, [pc, #176]	; (800170c <line_follower_until_color+0x128>)
 800165a:	ed93 8a03 	vldr	s16, [r3, #12]
 800165e:	eddf 7a2c 	vldr	s15, [pc, #176]	; 8001710 <line_follower_until_color+0x12c>
 8001662:	eeb8 8ac8 	vcvt.f32.s32	s16, s16
 8001666:	ee88 8a27 	vdiv.f32	s16, s16, s15
 800166a:	ee3a 8a48 	vsub.f32	s16, s20, s16
 800166e:	e001      	b.n	8001674 <line_follower_until_color+0x90>
 8001670:	eeb0 8a68 	vmov.f32	s16, s17
 8001674:	ed9f 9a27 	vldr	s18, [pc, #156]	; 8001714 <line_follower_until_color+0x130>
 8001678:	eeb4 8ac9 	vcmpe.f32	s16, s18
 800167c:	eef1 fa10 	vmrs	APSR_nzcv, fpscr
 8001680:	dc09      	bgt.n	8001696 <line_follower_until_color+0xb2>
 8001682:	eddf 7a25 	vldr	s15, [pc, #148]	; 8001718 <line_follower_until_color+0x134>
 8001686:	eeb4 8a67 	vcmp.f32	s16, s15
 800168a:	eef1 fa10 	vmrs	APSR_nzcv, fpscr
 800168e:	bf48      	it	mi
 8001690:	eeb0 8a67 	vmovmi.f32	s16, s15
 8001694:	e001      	b.n	800169a <line_follower_until_color+0xb6>
 8001696:	eeb0 8a49 	vmov.f32	s16, s18
 800169a:	ee78 7a68 	vsub.f32	s15, s16, s17
 800169e:	eddf 8a1f 	vldr	s17, [pc, #124]	; 800171c <line_follower_until_color+0x138>
 80016a2:	ee67 8aa8 	vmul.f32	s17, s15, s17
 80016a6:	eddf 7a1e 	vldr	s15, [pc, #120]	; 8001720 <line_follower_until_color+0x13c>
 80016aa:	ee18 0a10 	vmov	r0, s16
 80016ae:	ee48 8a27 	vmla.f32	s17, s16, s15
 80016b2:	f7fe fd69 	bl	8000188 <m_abs>
 80016b6:	ee07 0a90 	vmov	s15, r0
 80016ba:	ee39 9a67 	vsub.f32	s18, s18, s15
 80016be:	eddf 7a19 	vldr	s15, [pc, #100]	; 8001724 <line_follower_until_color+0x140>
 80016c2:	ee69 7a27 	vmul.f32	s15, s18, s15
 80016c6:	ee17 0a90 	vmov	r0, s15
 80016ca:	eddf 7a17 	vldr	s15, [pc, #92]	; 8001728 <line_follower_until_color+0x144>
 80016ce:	ee79 7aa7 	vadd.f32	s15, s19, s15
 80016d2:	ee17 1a90 	vmov	r1, s15
 80016d6:	f7fe fd63 	bl	80001a0 <m_min>
 80016da:	ee09 0a90 	vmov	s19, r0
 80016de:	ee79 7aa8 	vadd.f32	s15, s19, s17
 80016e2:	ee79 8ae8 	vsub.f32	s17, s19, s17
 80016e6:	eefd 7ae7 	vcvt.s32.f32	s15, s15
 80016ea:	eefd 8ae8 	vcvt.s32.f32	s17, s17
 80016ee:	200a      	movs	r0, #10
 80016f0:	edc6 7a00 	vstr	s15, [r6]
 80016f4:	edc6 8a01 	vstr	s17, [r6, #4]
 80016f8:	f000 fb80 	bl	8001dfc <timer_delay_ms>
 80016fc:	eef0 8a48 	vmov.f32	s17, s16
 8001700:	e77b      	b.n	80015fa <line_follower_until_color+0x16>
 8001702:	bf00      	nop
 8001704:	00000000 	.word	0x00000000
 8001708:	200000e4 	.word	0x200000e4
 800170c:	200000ec 	.word	0x200000ec
 8001710:	428c0000 	.word	0x428c0000
 8001714:	3f800000 	.word	0x3f800000
 8001718:	bf800000 	.word	0xbf800000
 800171c:	42c80000 	.word	0x42c80000
 8001720:	42200000 	.word	0x42200000
 8001724:	40a00000 	.word	0x40a00000
 8001728:	3e19999a 	.word	0x3e19999a

0800172c <line_follower_with_charging>:
 800172c:	e92d 4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
 8001730:	ed2d 8b06 	vpush	{d8-d10}
 8001734:	eddf 8a8e 	vldr	s17, [pc, #568]	; 8001970 <line_follower_with_charging+0x244>
 8001738:	2500      	movs	r5, #0
 800173a:	b083      	sub	sp, #12
 800173c:	4680      	mov	r8, r0
 800173e:	460f      	mov	r7, r1
 8001740:	4691      	mov	r9, r2
 8001742:	469a      	mov	sl, r3
 8001744:	eef0 9a68 	vmov.f32	s19, s17
 8001748:	462c      	mov	r4, r5
 800174a:	462e      	mov	r6, r5
 800174c:	eeb0 aa68 	vmov.f32	s20, s17
 8001750:	2e00      	cmp	r6, #0
 8001752:	f040 808b 	bne.w	800186c <line_follower_with_charging+0x140>
 8001756:	f7ff f8fb 	bl	8000950 <rgb_get_line_position>
 800175a:	4b86      	ldr	r3, [pc, #536]	; (8001974 <line_follower_with_charging+0x248>)
 800175c:	7c1a      	ldrb	r2, [r3, #16]
 800175e:	b122      	cbz	r2, 800176a <line_follower_with_charging+0x3e>
 8001760:	4b85      	ldr	r3, [pc, #532]	; (8001978 <line_follower_with_charging+0x24c>)
 8001762:	2564      	movs	r5, #100	; 0x64
 8001764:	601e      	str	r6, [r3, #0]
 8001766:	605e      	str	r6, [r3, #4]
 8001768:	e000      	b.n	800176c <line_follower_with_charging+0x40>
 800176a:	b125      	cbz	r5, 8001776 <line_follower_with_charging+0x4a>
 800176c:	200a      	movs	r0, #10
 800176e:	3d01      	subs	r5, #1
 8001770:	f000 fb44 	bl	8001dfc <timer_delay_ms>
 8001774:	e7ef      	b.n	8001756 <line_follower_with_charging+0x2a>
 8001776:	f1b8 0f03 	cmp.w	r8, #3
 800177a:	d817      	bhi.n	80017ac <line_follower_with_charging+0x80>
 800177c:	e8df f008 	tbb	[pc, r8]
 8001780:	0b080502 	.word	0x0b080502
 8001784:	ed93 8a00 	vldr	s16, [r3]
 8001788:	e007      	b.n	800179a <line_follower_with_charging+0x6e>
 800178a:	ed93 8a01 	vldr	s16, [r3, #4]
 800178e:	e004      	b.n	800179a <line_follower_with_charging+0x6e>
 8001790:	ed93 8a02 	vldr	s16, [r3, #8]
 8001794:	e001      	b.n	800179a <line_follower_with_charging+0x6e>
 8001796:	ed93 8a03 	vldr	s16, [r3, #12]
 800179a:	eddf 7a78 	vldr	s15, [pc, #480]	; 800197c <line_follower_with_charging+0x250>
 800179e:	eeb8 8ac8 	vcvt.f32.s32	s16, s16
 80017a2:	ee88 8a27 	vdiv.f32	s16, s16, s15
 80017a6:	ee3a 8a48 	vsub.f32	s16, s20, s16
 80017aa:	e001      	b.n	80017b0 <line_follower_with_charging+0x84>
 80017ac:	eeb0 8a68 	vmov.f32	s16, s17
 80017b0:	ed9f 9a73 	vldr	s18, [pc, #460]	; 8001980 <line_follower_with_charging+0x254>
 80017b4:	eeb4 8ac9 	vcmpe.f32	s16, s18
 80017b8:	eef1 fa10 	vmrs	APSR_nzcv, fpscr
 80017bc:	dc09      	bgt.n	80017d2 <line_follower_with_charging+0xa6>
 80017be:	eddf 7a71 	vldr	s15, [pc, #452]	; 8001984 <line_follower_with_charging+0x258>
 80017c2:	eeb4 8a67 	vcmp.f32	s16, s15
 80017c6:	eef1 fa10 	vmrs	APSR_nzcv, fpscr
 80017ca:	bf48      	it	mi
 80017cc:	eeb0 8a67 	vmovmi.f32	s16, s15
 80017d0:	e001      	b.n	80017d6 <line_follower_with_charging+0xaa>
 80017d2:	eeb0 8a49 	vmov.f32	s16, s18
 80017d6:	ee78 7a68 	vsub.f32	s15, s16, s17
 80017da:	eddf 8a6b 	vldr	s17, [pc, #428]	; 8001988 <line_follower_with_charging+0x25c>
 80017de:	f8df b198 	ldr.w	fp, [pc, #408]	; 8001978 <line_follower_with_charging+0x24c>
 80017e2:	ee67 8aa8 	vmul.f32	s17, s15, s17
 80017e6:	eddf 7a69 	vldr	s15, [pc, #420]	; 800198c <line_follower_with_charging+0x260>
 80017ea:	ee18 0a10 	vmov	r0, s16
 80017ee:	ee48 8a27 	vmla.f32	s17, s16, s15
 80017f2:	f7fe fcc9 	bl	8000188 <m_abs>
 80017f6:	ee07 0a90 	vmov	s15, r0
 80017fa:	ee39 9a67 	vsub.f32	s18, s18, s15
 80017fe:	eddf 7a64 	vldr	s15, [pc, #400]	; 8001990 <line_follower_with_charging+0x264>
 8001802:	ee69 7a27 	vmul.f32	s15, s18, s15
 8001806:	ee17 0a90 	vmov	r0, s15
 800180a:	eddf 7a62 	vldr	s15, [pc, #392]	; 8001994 <line_follower_with_charging+0x268>
 800180e:	ee79 7aa7 	vadd.f32	s15, s19, s15
 8001812:	ee17 1a90 	vmov	r1, s15
 8001816:	f7fe fcc3 	bl	80001a0 <m_min>
 800181a:	ee09 0a90 	vmov	s19, r0
 800181e:	ee79 7aa8 	vadd.f32	s15, s19, s17
 8001822:	ee79 8ae8 	vsub.f32	s17, s19, s17
 8001826:	eefd 7ae7 	vcvt.s32.f32	s15, s15
 800182a:	eefd 8ae8 	vcvt.s32.f32	s17, s17
 800182e:	200a      	movs	r0, #10
 8001830:	edcb 7a00 	vstr	s15, [fp]
 8001834:	edcb 8a01 	vstr	s17, [fp, #4]
 8001838:	f000 fae0 	bl	8001dfc <timer_delay_ms>
 800183c:	2064      	movs	r0, #100	; 0x64
 800183e:	f7fe fcbd 	bl	80001bc <getBatteryVoltage>
 8001842:	4548      	cmp	r0, r9
 8001844:	d226      	bcs.n	8001894 <line_follower_with_charging+0x168>
 8001846:	f5b4 7f7a 	cmp.w	r4, #1000	; 0x3e8
 800184a:	bfc1      	itttt	gt
 800184c:	2200      	movgt	r2, #0
 800184e:	f8cb 2000 	strgt.w	r2, [fp]
 8001852:	2601      	movgt	r6, #1
 8001854:	f8cb 2004 	strgt.w	r2, [fp, #4]
 8001858:	3401      	adds	r4, #1
 800185a:	eef0 8a48 	vmov.f32	s17, s16
 800185e:	e777      	b.n	8001750 <line_follower_with_charging+0x24>
 8001860:	4b4d      	ldr	r3, [pc, #308]	; (8001998 <line_follower_with_charging+0x26c>)
 8001862:	781b      	ldrb	r3, [r3, #0]
 8001864:	b3b3      	cbz	r3, 80018d4 <line_follower_with_charging+0x1a8>
 8001866:	2b01      	cmp	r3, #1
 8001868:	d12b      	bne.n	80018c2 <line_follower_with_charging+0x196>
 800186a:	2603      	movs	r6, #3
 800186c:	1e73      	subs	r3, r6, #1
 800186e:	2b05      	cmp	r3, #5
 8001870:	f63f af6e 	bhi.w	8001750 <line_follower_with_charging+0x24>
 8001874:	a201      	add	r2, pc, #4	; (adr r2, 800187c <line_follower_with_charging+0x150>)
 8001876:	f852 f023 	ldr.w	pc, [r2, r3, lsl #2]
 800187a:	bf00      	nop
 800187c:	0800189f 	.word	0x0800189f
 8001880:	08001861 	.word	0x08001861
 8001884:	08001903 	.word	0x08001903
 8001888:	080018e1 	.word	0x080018e1
 800188c:	0800190f 	.word	0x0800190f
 8001890:	08001945 	.word	0x08001945
 8001894:	b104      	cbz	r4, 8001898 <line_follower_with_charging+0x16c>
 8001896:	3c01      	subs	r4, #1
 8001898:	eef0 8a48 	vmov.f32	s17, s16
 800189c:	e75b      	b.n	8001756 <line_follower_with_charging+0x2a>
 800189e:	493e      	ldr	r1, [pc, #248]	; (8001998 <line_follower_with_charging+0x26c>)
 80018a0:	4a3e      	ldr	r2, [pc, #248]	; (800199c <line_follower_with_charging+0x270>)
 80018a2:	483f      	ldr	r0, [pc, #252]	; (80019a0 <line_follower_with_charging+0x274>)
 80018a4:	2300      	movs	r3, #0
 80018a6:	700b      	strb	r3, [r1, #0]
 80018a8:	2301      	movs	r3, #1
 80018aa:	7013      	strb	r3, [r2, #0]
 80018ac:	e88d 000a 	stmia.w	sp, {r1, r3}
 80018b0:	f643 2199 	movw	r1, #15001	; 0x3a99
 80018b4:	f7ff fa32 	bl	8000d1c <charging_send_message>
 80018b8:	2064      	movs	r0, #100	; 0x64
 80018ba:	f000 fa9f 	bl	8001dfc <timer_delay_ms>
 80018be:	2602      	movs	r6, #2
 80018c0:	e7d4      	b.n	800186c <line_follower_with_charging+0x140>
 80018c2:	2b02      	cmp	r3, #2
 80018c4:	d101      	bne.n	80018ca <line_follower_with_charging+0x19e>
 80018c6:	2604      	movs	r6, #4
 80018c8:	e7d0      	b.n	800186c <line_follower_with_charging+0x140>
 80018ca:	2b03      	cmp	r3, #3
 80018cc:	d102      	bne.n	80018d4 <line_follower_with_charging+0x1a8>
 80018ce:	f241 3088 	movw	r0, #5000	; 0x1388
 80018d2:	e001      	b.n	80018d8 <line_follower_with_charging+0x1ac>
 80018d4:	f44f 707a 	mov.w	r0, #1000	; 0x3e8
 80018d8:	f000 fa90 	bl	8001dfc <timer_delay_ms>
 80018dc:	2601      	movs	r6, #1
 80018de:	e7c5      	b.n	800186c <line_follower_with_charging+0x140>
 80018e0:	4638      	mov	r0, r7
 80018e2:	f7ff fe39 	bl	8001558 <charging_test_go_straight_until_line>
 80018e6:	4b2f      	ldr	r3, [pc, #188]	; (80019a4 <line_follower_with_charging+0x278>)
 80018e8:	88db      	ldrh	r3, [r3, #6]
 80018ea:	b21b      	sxth	r3, r3
 80018ec:	2b28      	cmp	r3, #40	; 0x28
 80018ee:	dd08      	ble.n	8001902 <line_follower_with_charging+0x1d6>
 80018f0:	f44f 707a 	mov.w	r0, #1000	; 0x3e8
 80018f4:	2114      	movs	r1, #20
 80018f6:	2201      	movs	r2, #1
 80018f8:	f7ff fe5a 	bl	80015b0 <slightTurn>
 80018fc:	2001      	movs	r0, #1
 80018fe:	f7ff fe2b 	bl	8001558 <charging_test_go_straight_until_line>
 8001902:	4638      	mov	r0, r7
 8001904:	2100      	movs	r1, #0
 8001906:	f7ff fe6d 	bl	80015e4 <line_follower_until_color>
 800190a:	2605      	movs	r6, #5
 800190c:	e7ae      	b.n	800186c <line_follower_with_charging+0x140>
 800190e:	4b1a      	ldr	r3, [pc, #104]	; (8001978 <line_follower_with_charging+0x24c>)
 8001910:	2200      	movs	r2, #0
 8001912:	605a      	str	r2, [r3, #4]
 8001914:	601a      	str	r2, [r3, #0]
 8001916:	f7fe fc77 	bl	8000208 <getChargingVoltage>
 800191a:	9b12      	ldr	r3, [sp, #72]	; 0x48
 800191c:	4298      	cmp	r0, r3
 800191e:	f4ff af17 	bcc.w	8001750 <line_follower_with_charging+0x24>
 8001922:	4a1e      	ldr	r2, [pc, #120]	; (800199c <line_follower_with_charging+0x270>)
 8001924:	481e      	ldr	r0, [pc, #120]	; (80019a0 <line_follower_with_charging+0x274>)
 8001926:	2302      	movs	r3, #2
 8001928:	7013      	strb	r3, [r2, #0]
 800192a:	4b1b      	ldr	r3, [pc, #108]	; (8001998 <line_follower_with_charging+0x26c>)
 800192c:	9300      	str	r3, [sp, #0]
 800192e:	2301      	movs	r3, #1
 8001930:	9301      	str	r3, [sp, #4]
 8001932:	f643 2199 	movw	r1, #15001	; 0x3a99
 8001936:	f7ff f9f1 	bl	8000d1c <charging_send_message>
 800193a:	2064      	movs	r0, #100	; 0x64
 800193c:	f000 fa5e 	bl	8001dfc <timer_delay_ms>
 8001940:	2606      	movs	r6, #6
 8001942:	e793      	b.n	800186c <line_follower_with_charging+0x140>
 8001944:	2064      	movs	r0, #100	; 0x64
 8001946:	f7fe fc39 	bl	80001bc <getBatteryVoltage>
 800194a:	4550      	cmp	r0, sl
 800194c:	f67f af00 	bls.w	8001750 <line_follower_with_charging+0x24>
 8001950:	4c09      	ldr	r4, [pc, #36]	; (8001978 <line_follower_with_charging+0x24c>)
 8001952:	f06f 0309 	mvn.w	r3, #9
 8001956:	f44f 607a 	mov.w	r0, #4000	; 0xfa0
 800195a:	6023      	str	r3, [r4, #0]
 800195c:	6063      	str	r3, [r4, #4]
 800195e:	f000 fa4d 	bl	8001dfc <timer_delay_ms>
 8001962:	2300      	movs	r3, #0
 8001964:	6023      	str	r3, [r4, #0]
 8001966:	461e      	mov	r6, r3
 8001968:	6063      	str	r3, [r4, #4]
 800196a:	461c      	mov	r4, r3
 800196c:	e6f3      	b.n	8001756 <line_follower_with_charging+0x2a>
 800196e:	bf00      	nop
 8001970:	00000000 	.word	0x00000000
 8001974:	200000ec 	.word	0x200000ec
 8001978:	200000e4 	.word	0x200000e4
 800197c:	428c0000 	.word	0x428c0000
 8001980:	3f800000 	.word	0x3f800000
 8001984:	bf800000 	.word	0xbf800000
 8001988:	42c80000 	.word	0x42c80000
 800198c:	42200000 	.word	0x42200000
 8001990:	41a00000 	.word	0x41a00000
 8001994:	3e4ccccd 	.word	0x3e4ccccd
 8001998:	20000104 	.word	0x20000104
 800199c:	20000184 	.word	0x20000184
 80019a0:	08002d71 	.word	0x08002d71
 80019a4:	20000064 	.word	0x20000064

080019a8 <device_sleep>:
 80019a8:	4b01      	ldr	r3, [pc, #4]	; (80019b0 <device_sleep+0x8>)
 80019aa:	22ff      	movs	r2, #255	; 0xff
 80019ac:	701a      	strb	r2, [r3, #0]
 80019ae:	4770      	bx	lr
 80019b0:	20000030 	.word	0x20000030

080019b4 <device_wake_up>:
 80019b4:	4b01      	ldr	r3, [pc, #4]	; (80019bc <device_wake_up+0x8>)
 80019b6:	2200      	movs	r2, #0
 80019b8:	701a      	strb	r2, [r3, #0]
 80019ba:	4770      	bx	lr
 80019bc:	20000030 	.word	0x20000030

080019c0 <device_i2c_thread>:
 80019c0:	b538      	push	{r3, r4, r5, lr}
 80019c2:	2000      	movs	r0, #0
 80019c4:	210a      	movs	r1, #10
 80019c6:	f000 fa29 	bl	8001e1c <event_timer_set_period>
 80019ca:	2501      	movs	r5, #1
 80019cc:	2400      	movs	r4, #0
 80019ce:	2c01      	cmp	r4, #1
 80019d0:	d016      	beq.n	8001a00 <device_i2c_thread+0x40>
 80019d2:	d30e      	bcc.n	80019f2 <device_i2c_thread+0x32>
 80019d4:	2c02      	cmp	r4, #2
 80019d6:	d1fa      	bne.n	80019ce <device_i2c_thread+0xe>
 80019d8:	f7fe fd41 	bl	800045e <lsm9ds0_uninit>
 80019dc:	f7ff fa88 	bl	8000ef0 <motors_uninit>
 80019e0:	2064      	movs	r0, #100	; 0x64
 80019e2:	f000 fa0b 	bl	8001dfc <timer_delay_ms>
 80019e6:	4b0d      	ldr	r3, [pc, #52]	; (8001a1c <device_i2c_thread+0x5c>)
 80019e8:	781b      	ldrb	r3, [r3, #0]
 80019ea:	2b00      	cmp	r3, #0
 80019ec:	bf08      	it	eq
 80019ee:	2400      	moveq	r4, #0
 80019f0:	e7ed      	b.n	80019ce <device_i2c_thread+0xe>
 80019f2:	f7ff fb11 	bl	8001018 <motors_init>
 80019f6:	4628      	mov	r0, r5
 80019f8:	f7fe fe06 	bl	8000608 <lsm9ds0_init>
 80019fc:	2500      	movs	r5, #0
 80019fe:	2401      	movs	r4, #1
 8001a00:	2000      	movs	r0, #0
 8001a02:	f000 fa23 	bl	8001e4c <event_timer_wait>
 8001a06:	f7fe fd3d 	bl	8000484 <lsm9ds0_read>
 8001a0a:	f7ff fa7f 	bl	8000f0c <motors_update>
 8001a0e:	4b03      	ldr	r3, [pc, #12]	; (8001a1c <device_i2c_thread+0x5c>)
 8001a10:	781b      	ldrb	r3, [r3, #0]
 8001a12:	2b00      	cmp	r3, #0
 8001a14:	bf18      	it	ne
 8001a16:	2402      	movne	r4, #2
 8001a18:	e7d9      	b.n	80019ce <device_i2c_thread+0xe>
 8001a1a:	bf00      	nop
 8001a1c:	20000030 	.word	0x20000030

08001a20 <device_rgb_sensors_thread>:
 8001a20:	b510      	push	{r4, lr}
 8001a22:	2001      	movs	r0, #1
 8001a24:	210a      	movs	r1, #10
 8001a26:	f000 f9f9 	bl	8001e1c <event_timer_set_period>
 8001a2a:	2400      	movs	r4, #0
 8001a2c:	2001      	movs	r0, #1
 8001a2e:	f000 fa0d 	bl	8001e4c <event_timer_wait>
 8001a32:	2c01      	cmp	r4, #1
 8001a34:	d019      	beq.n	8001a6a <device_rgb_sensors_thread+0x4a>
 8001a36:	d30c      	bcc.n	8001a52 <device_rgb_sensors_thread+0x32>
 8001a38:	2c02      	cmp	r4, #2
 8001a3a:	d1f7      	bne.n	8001a2c <device_rgb_sensors_thread+0xc>
 8001a3c:	f7fe fe3a 	bl	80006b4 <rgb_sensor_uninit>
 8001a40:	2064      	movs	r0, #100	; 0x64
 8001a42:	f000 f9db 	bl	8001dfc <timer_delay_ms>
 8001a46:	4b0d      	ldr	r3, [pc, #52]	; (8001a7c <device_rgb_sensors_thread+0x5c>)
 8001a48:	781b      	ldrb	r3, [r3, #0]
 8001a4a:	2b00      	cmp	r3, #0
 8001a4c:	bf08      	it	eq
 8001a4e:	2400      	moveq	r4, #0
 8001a50:	e7ec      	b.n	8001a2c <device_rgb_sensors_thread+0xc>
 8001a52:	f7fe ff25 	bl	80008a0 <rgb_sensor_init>
 8001a56:	4604      	mov	r4, r0
 8001a58:	b128      	cbz	r0, 8001a66 <device_rgb_sensors_thread+0x46>
 8001a5a:	f7fe fe2b 	bl	80006b4 <rgb_sensor_uninit>
 8001a5e:	2001      	movs	r0, #1
 8001a60:	4621      	mov	r1, r4
 8001a62:	f7ff fd59 	bl	8001518 <abort_error_>
 8001a66:	2401      	movs	r4, #1
 8001a68:	e7e0      	b.n	8001a2c <device_rgb_sensors_thread+0xc>
 8001a6a:	f7fe fe2f 	bl	80006cc <rgb_sensor_read>
 8001a6e:	4b03      	ldr	r3, [pc, #12]	; (8001a7c <device_rgb_sensors_thread+0x5c>)
 8001a70:	781b      	ldrb	r3, [r3, #0]
 8001a72:	2b00      	cmp	r3, #0
 8001a74:	d0f7      	beq.n	8001a66 <device_rgb_sensors_thread+0x46>
 8001a76:	2402      	movs	r4, #2
 8001a78:	e7d8      	b.n	8001a2c <device_rgb_sensors_thread+0xc>
 8001a7a:	bf00      	nop
 8001a7c:	20000030 	.word	0x20000030

08001a80 <device_wifi_thread>:
 8001a80:	b510      	push	{r4, lr}
 8001a82:	2400      	movs	r4, #0
 8001a84:	b164      	cbz	r4, 8001aa0 <device_wifi_thread+0x20>
 8001a86:	2c02      	cmp	r4, #2
 8001a88:	d1fc      	bne.n	8001a84 <device_wifi_thread+0x4>
 8001a8a:	f7ff f91b 	bl	8000cc4 <esp8266_uninit>
 8001a8e:	2064      	movs	r0, #100	; 0x64
 8001a90:	f000 f9b4 	bl	8001dfc <timer_delay_ms>
 8001a94:	4b0d      	ldr	r3, [pc, #52]	; (8001acc <device_wifi_thread+0x4c>)
 8001a96:	781b      	ldrb	r3, [r3, #0]
 8001a98:	2b00      	cmp	r3, #0
 8001a9a:	bf08      	it	eq
 8001a9c:	2400      	moveq	r4, #0
 8001a9e:	e7f1      	b.n	8001a84 <device_wifi_thread+0x4>
 8001aa0:	2001      	movs	r0, #1
 8001aa2:	f000 fedf 	bl	8002864 <led_on>
 8001aa6:	f7ff f9f5 	bl	8000e94 <tcp_init>
 8001aaa:	4620      	mov	r0, r4
 8001aac:	f7ff f8b8 	bl	8000c20 <esp8266_init>
 8001ab0:	4604      	mov	r4, r0
 8001ab2:	b128      	cbz	r0, 8001ac0 <device_wifi_thread+0x40>
 8001ab4:	f7ff f906 	bl	8000cc4 <esp8266_uninit>
 8001ab8:	2003      	movs	r0, #3
 8001aba:	4621      	mov	r1, r4
 8001abc:	f7ff fd2c 	bl	8001518 <abort_error_>
 8001ac0:	2064      	movs	r0, #100	; 0x64
 8001ac2:	f000 f99b 	bl	8001dfc <timer_delay_ms>
 8001ac6:	2401      	movs	r4, #1
 8001ac8:	e7dc      	b.n	8001a84 <device_wifi_thread+0x4>
 8001aca:	bf00      	nop
 8001acc:	20000030 	.word	0x20000030

08001ad0 <main_thread>:
 8001ad0:	b507      	push	{r0, r1, r2, lr}
 8001ad2:	4829      	ldr	r0, [pc, #164]	; (8001b78 <main_thread+0xa8>)
 8001ad4:	f7ff fc3e 	bl	8001354 <printf_>
 8001ad8:	f44f 70fa 	mov.w	r0, #500	; 0x1f4
 8001adc:	f000 f98e 	bl	8001dfc <timer_delay_ms>
 8001ae0:	f7ff ff68 	bl	80019b4 <device_wake_up>
 8001ae4:	4925      	ldr	r1, [pc, #148]	; (8001b7c <main_thread+0xac>)
 8001ae6:	4826      	ldr	r0, [pc, #152]	; (8001b80 <main_thread+0xb0>)
 8001ae8:	f44f 7200 	mov.w	r2, #512	; 0x200
 8001aec:	2306      	movs	r3, #6
 8001aee:	f7ff fb21 	bl	8001134 <create_thread>
 8001af2:	4924      	ldr	r1, [pc, #144]	; (8001b84 <main_thread+0xb4>)
 8001af4:	4824      	ldr	r0, [pc, #144]	; (8001b88 <main_thread+0xb8>)
 8001af6:	f44f 7200 	mov.w	r2, #512	; 0x200
 8001afa:	2306      	movs	r3, #6
 8001afc:	f7ff fb1a 	bl	8001134 <create_thread>
 8001b00:	4922      	ldr	r1, [pc, #136]	; (8001b8c <main_thread+0xbc>)
 8001b02:	4823      	ldr	r0, [pc, #140]	; (8001b90 <main_thread+0xc0>)
 8001b04:	f44f 7200 	mov.w	r2, #512	; 0x200
 8001b08:	2306      	movs	r3, #6
 8001b0a:	f7ff fb13 	bl	8001134 <create_thread>
 8001b0e:	20c8      	movs	r0, #200	; 0xc8
 8001b10:	f000 f974 	bl	8001dfc <timer_delay_ms>
 8001b14:	f7fe ffcc 	bl	8000ab0 <rgb_set_background>
 8001b18:	f000 ff36 	bl	8002988 <get_key>
 8001b1c:	b980      	cbnz	r0, 8001b40 <main_thread+0x70>
 8001b1e:	f44f 4000 	mov.w	r0, #32768	; 0x8000
 8001b22:	f000 fe9f 	bl	8002864 <led_on>
 8001b26:	2064      	movs	r0, #100	; 0x64
 8001b28:	f000 f968 	bl	8001dfc <timer_delay_ms>
 8001b2c:	f44f 4000 	mov.w	r0, #32768	; 0x8000
 8001b30:	f000 feae 	bl	8002890 <led_off>
 8001b34:	20c8      	movs	r0, #200	; 0xc8
 8001b36:	f000 f961 	bl	8001dfc <timer_delay_ms>
 8001b3a:	f7ff ff35 	bl	80019a8 <device_sleep>
 8001b3e:	e7eb      	b.n	8001b18 <main_thread+0x48>
 8001b40:	f7ff ff38 	bl	80019b4 <device_wake_up>
 8001b44:	20c8      	movs	r0, #200	; 0xc8
 8001b46:	f000 f959 	bl	8001dfc <timer_delay_ms>
 8001b4a:	f241 3324 	movw	r3, #4900	; 0x1324
 8001b4e:	9300      	str	r3, [sp, #0]
 8001b50:	2002      	movs	r0, #2
 8001b52:	2101      	movs	r1, #1
 8001b54:	f44f 6261 	mov.w	r2, #3600	; 0xe10
 8001b58:	f241 0304 	movw	r3, #4100	; 0x1004
 8001b5c:	f7ff fde6 	bl	800172c <line_follower_with_charging>
 8001b60:	f44f 4000 	mov.w	r0, #32768	; 0x8000
 8001b64:	f000 fe7e 	bl	8002864 <led_on>
 8001b68:	f000 ff0e 	bl	8002988 <get_key>
 8001b6c:	2800      	cmp	r0, #0
 8001b6e:	d1d3      	bne.n	8001b18 <main_thread+0x48>
 8001b70:	f7fe feee 	bl	8000950 <rgb_get_line_position>
 8001b74:	e7f8      	b.n	8001b68 <main_thread+0x98>
 8001b76:	bf00      	nop
 8001b78:	08002e09 	.word	0x08002e09
 8001b7c:	20000690 	.word	0x20000690
 8001b80:	08001a21 	.word	0x08001a21
 8001b84:	20000490 	.word	0x20000490
 8001b88:	080019c1 	.word	0x080019c1
 8001b8c:	20000890 	.word	0x20000890
 8001b90:	08001a81 	.word	0x08001a81

08001b94 <lib_low_level_init>:
 8001b94:	b508      	push	{r3, lr}
 8001b96:	f000 fde5 	bl	8002764 <sytem_clock_init>
 8001b9a:	f000 fe8f 	bl	80028bc <gpio_init>
 8001b9e:	f000 fcfb 	bl	8002598 <uart_init>
 8001ba2:	f000 f8a5 	bl	8001cf0 <timer_init>
 8001ba6:	f000 ffb1 	bl	8002b0c <i2c_0_init>
 8001baa:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 8001bae:	f000 bb0f 	b.w	80021d0 <adc_init>
	...

08001bb4 <NVIC_Init>:
 8001bb4:	b510      	push	{r4, lr}
 8001bb6:	bf00      	nop
 8001bb8:	bf00      	nop
 8001bba:	bf00      	nop
 8001bbc:	78c2      	ldrb	r2, [r0, #3]
 8001bbe:	7803      	ldrb	r3, [r0, #0]
 8001bc0:	b312      	cbz	r2, 8001c08 <NVIC_Init+0x54>
 8001bc2:	4a17      	ldr	r2, [pc, #92]	; (8001c20 <NVIC_Init+0x6c>)
 8001bc4:	68d1      	ldr	r1, [r2, #12]
 8001bc6:	7842      	ldrb	r2, [r0, #1]
 8001bc8:	43c9      	mvns	r1, r1
 8001bca:	f3c1 2102 	ubfx	r1, r1, #8, #3
 8001bce:	f1c1 0404 	rsb	r4, r1, #4
 8001bd2:	b2e4      	uxtb	r4, r4
 8001bd4:	40a2      	lsls	r2, r4
 8001bd6:	b2d4      	uxtb	r4, r2
 8001bd8:	220f      	movs	r2, #15
 8001bda:	410a      	asrs	r2, r1
 8001bdc:	7881      	ldrb	r1, [r0, #2]
 8001bde:	400a      	ands	r2, r1
 8001be0:	4322      	orrs	r2, r4
 8001be2:	f103 4360 	add.w	r3, r3, #3758096384	; 0xe0000000
 8001be6:	f503 4361 	add.w	r3, r3, #57600	; 0xe100
 8001bea:	0112      	lsls	r2, r2, #4
 8001bec:	b2d2      	uxtb	r2, r2
 8001bee:	f883 2300 	strb.w	r2, [r3, #768]	; 0x300
 8001bf2:	7803      	ldrb	r3, [r0, #0]
 8001bf4:	2201      	movs	r2, #1
 8001bf6:	0959      	lsrs	r1, r3, #5
 8001bf8:	f003 031f 	and.w	r3, r3, #31
 8001bfc:	fa02 f303 	lsl.w	r3, r2, r3
 8001c00:	4a08      	ldr	r2, [pc, #32]	; (8001c24 <NVIC_Init+0x70>)
 8001c02:	f842 3021 	str.w	r3, [r2, r1, lsl #2]
 8001c06:	bd10      	pop	{r4, pc}
 8001c08:	095a      	lsrs	r2, r3, #5
 8001c0a:	2101      	movs	r1, #1
 8001c0c:	f003 031f 	and.w	r3, r3, #31
 8001c10:	4099      	lsls	r1, r3
 8001c12:	f102 0320 	add.w	r3, r2, #32
 8001c16:	4a03      	ldr	r2, [pc, #12]	; (8001c24 <NVIC_Init+0x70>)
 8001c18:	f842 1023 	str.w	r1, [r2, r3, lsl #2]
 8001c1c:	bd10      	pop	{r4, pc}
 8001c1e:	bf00      	nop
 8001c20:	e000ed00 	.word	0xe000ed00
 8001c24:	e000e100 	.word	0xe000e100

08001c28 <TIM_TimeBaseInit>:
 8001c28:	bf00      	nop
 8001c2a:	bf00      	nop
 8001c2c:	bf00      	nop
 8001c2e:	4a24      	ldr	r2, [pc, #144]	; (8001cc0 <TIM_TimeBaseInit+0x98>)
 8001c30:	8803      	ldrh	r3, [r0, #0]
 8001c32:	4290      	cmp	r0, r2
 8001c34:	b29b      	uxth	r3, r3
 8001c36:	d012      	beq.n	8001c5e <TIM_TimeBaseInit+0x36>
 8001c38:	f502 6200 	add.w	r2, r2, #2048	; 0x800
 8001c3c:	4290      	cmp	r0, r2
 8001c3e:	d00e      	beq.n	8001c5e <TIM_TimeBaseInit+0x36>
 8001c40:	f1b0 4f80 	cmp.w	r0, #1073741824	; 0x40000000
 8001c44:	d00b      	beq.n	8001c5e <TIM_TimeBaseInit+0x36>
 8001c46:	f5a2 3298 	sub.w	r2, r2, #77824	; 0x13000
 8001c4a:	4290      	cmp	r0, r2
 8001c4c:	d007      	beq.n	8001c5e <TIM_TimeBaseInit+0x36>
 8001c4e:	f502 6280 	add.w	r2, r2, #1024	; 0x400
 8001c52:	4290      	cmp	r0, r2
 8001c54:	d003      	beq.n	8001c5e <TIM_TimeBaseInit+0x36>
 8001c56:	f502 32a4 	add.w	r2, r2, #83968	; 0x14800
 8001c5a:	4290      	cmp	r0, r2
 8001c5c:	d103      	bne.n	8001c66 <TIM_TimeBaseInit+0x3e>
 8001c5e:	884a      	ldrh	r2, [r1, #2]
 8001c60:	f023 0370 	bic.w	r3, r3, #112	; 0x70
 8001c64:	4313      	orrs	r3, r2
 8001c66:	4a17      	ldr	r2, [pc, #92]	; (8001cc4 <TIM_TimeBaseInit+0x9c>)
 8001c68:	4290      	cmp	r0, r2
 8001c6a:	d008      	beq.n	8001c7e <TIM_TimeBaseInit+0x56>
 8001c6c:	f502 6280 	add.w	r2, r2, #1024	; 0x400
 8001c70:	4290      	cmp	r0, r2
 8001c72:	bf1f      	itttt	ne
 8001c74:	f423 7340 	bicne.w	r3, r3, #768	; 0x300
 8001c78:	890a      	ldrhne	r2, [r1, #8]
 8001c7a:	b29b      	uxthne	r3, r3
 8001c7c:	4313      	orrne	r3, r2
 8001c7e:	8003      	strh	r3, [r0, #0]
 8001c80:	684b      	ldr	r3, [r1, #4]
 8001c82:	62c3      	str	r3, [r0, #44]	; 0x2c
 8001c84:	880b      	ldrh	r3, [r1, #0]
 8001c86:	8503      	strh	r3, [r0, #40]	; 0x28
 8001c88:	4b0d      	ldr	r3, [pc, #52]	; (8001cc0 <TIM_TimeBaseInit+0x98>)
 8001c8a:	4298      	cmp	r0, r3
 8001c8c:	d013      	beq.n	8001cb6 <TIM_TimeBaseInit+0x8e>
 8001c8e:	f503 6300 	add.w	r3, r3, #2048	; 0x800
 8001c92:	4298      	cmp	r0, r3
 8001c94:	d00f      	beq.n	8001cb6 <TIM_TimeBaseInit+0x8e>
 8001c96:	f503 6340 	add.w	r3, r3, #3072	; 0xc00
 8001c9a:	4298      	cmp	r0, r3
 8001c9c:	d00b      	beq.n	8001cb6 <TIM_TimeBaseInit+0x8e>
 8001c9e:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 8001ca2:	4298      	cmp	r0, r3
 8001ca4:	d007      	beq.n	8001cb6 <TIM_TimeBaseInit+0x8e>
 8001ca6:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 8001caa:	4298      	cmp	r0, r3
 8001cac:	d003      	beq.n	8001cb6 <TIM_TimeBaseInit+0x8e>
 8001cae:	f503 6300 	add.w	r3, r3, #2048	; 0x800
 8001cb2:	4298      	cmp	r0, r3
 8001cb4:	d101      	bne.n	8001cba <TIM_TimeBaseInit+0x92>
 8001cb6:	894b      	ldrh	r3, [r1, #10]
 8001cb8:	8603      	strh	r3, [r0, #48]	; 0x30
 8001cba:	2301      	movs	r3, #1
 8001cbc:	6143      	str	r3, [r0, #20]
 8001cbe:	4770      	bx	lr
 8001cc0:	40012c00 	.word	0x40012c00
 8001cc4:	40001000 	.word	0x40001000

08001cc8 <TIM_Cmd>:
 8001cc8:	bf00      	nop
 8001cca:	bf00      	nop
 8001ccc:	8803      	ldrh	r3, [r0, #0]
 8001cce:	b119      	cbz	r1, 8001cd8 <TIM_Cmd+0x10>
 8001cd0:	b29b      	uxth	r3, r3
 8001cd2:	f043 0301 	orr.w	r3, r3, #1
 8001cd6:	e003      	b.n	8001ce0 <TIM_Cmd+0x18>
 8001cd8:	f023 0301 	bic.w	r3, r3, #1
 8001cdc:	041b      	lsls	r3, r3, #16
 8001cde:	0c1b      	lsrs	r3, r3, #16
 8001ce0:	8003      	strh	r3, [r0, #0]
 8001ce2:	4770      	bx	lr

08001ce4 <TIM_ClearITPendingBit>:
 8001ce4:	bf00      	nop
 8001ce6:	43c9      	mvns	r1, r1
 8001ce8:	b289      	uxth	r1, r1
 8001cea:	6101      	str	r1, [r0, #16]
 8001cec:	4770      	bx	lr
	...

08001cf0 <timer_init>:
 8001cf0:	b530      	push	{r4, r5, lr}
 8001cf2:	2300      	movs	r3, #0
 8001cf4:	b085      	sub	sp, #20
 8001cf6:	491f      	ldr	r1, [pc, #124]	; (8001d74 <timer_init+0x84>)
 8001cf8:	f44f 6280 	mov.w	r2, #1024	; 0x400
 8001cfc:	f821 2013 	strh.w	r2, [r1, r3, lsl #1]
 8001d00:	491d      	ldr	r1, [pc, #116]	; (8001d78 <timer_init+0x88>)
 8001d02:	f821 2013 	strh.w	r2, [r1, r3, lsl #1]
 8001d06:	4a1d      	ldr	r2, [pc, #116]	; (8001d7c <timer_init+0x8c>)
 8001d08:	2400      	movs	r4, #0
 8001d0a:	f822 4013 	strh.w	r4, [r2, r3, lsl #1]
 8001d0e:	3301      	adds	r3, #1
 8001d10:	2b04      	cmp	r3, #4
 8001d12:	4625      	mov	r5, r4
 8001d14:	d1ef      	bne.n	8001cf6 <timer_init+0x6>
 8001d16:	4b1a      	ldr	r3, [pc, #104]	; (8001d80 <timer_init+0x90>)
 8001d18:	2002      	movs	r0, #2
 8001d1a:	2101      	movs	r1, #1
 8001d1c:	601c      	str	r4, [r3, #0]
 8001d1e:	f000 fa49 	bl	80021b4 <RCC_APB1PeriphClockCmd>
 8001d22:	f8ad 4006 	strh.w	r4, [sp, #6]
 8001d26:	f8ad 400c 	strh.w	r4, [sp, #12]
 8001d2a:	f8ad 400e 	strh.w	r4, [sp, #14]
 8001d2e:	4c15      	ldr	r4, [pc, #84]	; (8001d84 <timer_init+0x94>)
 8001d30:	f44f 738c 	mov.w	r3, #280	; 0x118
 8001d34:	f8ad 3004 	strh.w	r3, [sp, #4]
 8001d38:	4620      	mov	r0, r4
 8001d3a:	2331      	movs	r3, #49	; 0x31
 8001d3c:	a901      	add	r1, sp, #4
 8001d3e:	9302      	str	r3, [sp, #8]
 8001d40:	f7ff ff72 	bl	8001c28 <TIM_TimeBaseInit>
 8001d44:	4620      	mov	r0, r4
 8001d46:	2101      	movs	r1, #1
 8001d48:	f7ff ffbe 	bl	8001cc8 <TIM_Cmd>
 8001d4c:	68e3      	ldr	r3, [r4, #12]
 8001d4e:	f043 0301 	orr.w	r3, r3, #1
 8001d52:	60e3      	str	r3, [r4, #12]
 8001d54:	231d      	movs	r3, #29
 8001d56:	f88d 3000 	strb.w	r3, [sp]
 8001d5a:	4668      	mov	r0, sp
 8001d5c:	2301      	movs	r3, #1
 8001d5e:	f88d 5001 	strb.w	r5, [sp, #1]
 8001d62:	f88d 3002 	strb.w	r3, [sp, #2]
 8001d66:	f88d 3003 	strb.w	r3, [sp, #3]
 8001d6a:	f7ff ff23 	bl	8001bb4 <NVIC_Init>
 8001d6e:	b005      	add	sp, #20
 8001d70:	bd30      	pop	{r4, r5, pc}
 8001d72:	bf00      	nop
 8001d74:	20000ca4 	.word	0x20000ca4
 8001d78:	20000c98 	.word	0x20000c98
 8001d7c:	20000c90 	.word	0x20000c90
 8001d80:	20000ca0 	.word	0x20000ca0
 8001d84:	40000400 	.word	0x40000400

08001d88 <TIM3_IRQHandler>:
 8001d88:	2300      	movs	r3, #0
 8001d8a:	4910      	ldr	r1, [pc, #64]	; (8001dcc <TIM3_IRQHandler+0x44>)
 8001d8c:	f831 2013 	ldrh.w	r2, [r1, r3, lsl #1]
 8001d90:	b292      	uxth	r2, r2
 8001d92:	b132      	cbz	r2, 8001da2 <TIM3_IRQHandler+0x1a>
 8001d94:	f831 2013 	ldrh.w	r2, [r1, r3, lsl #1]
 8001d98:	3a01      	subs	r2, #1
 8001d9a:	b292      	uxth	r2, r2
 8001d9c:	f821 2013 	strh.w	r2, [r1, r3, lsl #1]
 8001da0:	e009      	b.n	8001db6 <TIM3_IRQHandler+0x2e>
 8001da2:	4a0b      	ldr	r2, [pc, #44]	; (8001dd0 <TIM3_IRQHandler+0x48>)
 8001da4:	f832 2013 	ldrh.w	r2, [r2, r3, lsl #1]
 8001da8:	b292      	uxth	r2, r2
 8001daa:	f821 2013 	strh.w	r2, [r1, r3, lsl #1]
 8001dae:	4a09      	ldr	r2, [pc, #36]	; (8001dd4 <TIM3_IRQHandler+0x4c>)
 8001db0:	2101      	movs	r1, #1
 8001db2:	f822 1013 	strh.w	r1, [r2, r3, lsl #1]
 8001db6:	3301      	adds	r3, #1
 8001db8:	2b04      	cmp	r3, #4
 8001dba:	d1e6      	bne.n	8001d8a <TIM3_IRQHandler+0x2>
 8001dbc:	4a06      	ldr	r2, [pc, #24]	; (8001dd8 <TIM3_IRQHandler+0x50>)
 8001dbe:	4807      	ldr	r0, [pc, #28]	; (8001ddc <TIM3_IRQHandler+0x54>)
 8001dc0:	6813      	ldr	r3, [r2, #0]
 8001dc2:	2101      	movs	r1, #1
 8001dc4:	3301      	adds	r3, #1
 8001dc6:	6013      	str	r3, [r2, #0]
 8001dc8:	f7ff bf8c 	b.w	8001ce4 <TIM_ClearITPendingBit>
 8001dcc:	20000ca4 	.word	0x20000ca4
 8001dd0:	20000c98 	.word	0x20000c98
 8001dd4:	20000c90 	.word	0x20000c90
 8001dd8:	20000ca0 	.word	0x20000ca0
 8001ddc:	40000400 	.word	0x40000400

08001de0 <timer_get_time>:
 8001de0:	b082      	sub	sp, #8
 8001de2:	b672      	cpsid	i
 8001de4:	4b04      	ldr	r3, [pc, #16]	; (8001df8 <timer_get_time+0x18>)
 8001de6:	681b      	ldr	r3, [r3, #0]
 8001de8:	9301      	str	r3, [sp, #4]
 8001dea:	b662      	cpsie	i
 8001dec:	230a      	movs	r3, #10
 8001dee:	9801      	ldr	r0, [sp, #4]
 8001df0:	fbb0 f0f3 	udiv	r0, r0, r3
 8001df4:	b002      	add	sp, #8
 8001df6:	4770      	bx	lr
 8001df8:	20000ca0 	.word	0x20000ca0

08001dfc <timer_delay_ms>:
 8001dfc:	b513      	push	{r0, r1, r4, lr}
 8001dfe:	4604      	mov	r4, r0
 8001e00:	f7ff ffee 	bl	8001de0 <timer_get_time>
 8001e04:	4420      	add	r0, r4
 8001e06:	9001      	str	r0, [sp, #4]
 8001e08:	9c01      	ldr	r4, [sp, #4]
 8001e0a:	f7ff ffe9 	bl	8001de0 <timer_get_time>
 8001e0e:	4284      	cmp	r4, r0
 8001e10:	d902      	bls.n	8001e18 <timer_delay_ms+0x1c>
 8001e12:	f000 fca5 	bl	8002760 <sleep>
 8001e16:	e7f7      	b.n	8001e08 <timer_delay_ms+0xc>
 8001e18:	b002      	add	sp, #8
 8001e1a:	bd10      	pop	{r4, pc}

08001e1c <event_timer_set_period>:
 8001e1c:	b672      	cpsid	i
 8001e1e:	eb01 0181 	add.w	r1, r1, r1, lsl #2
 8001e22:	4b07      	ldr	r3, [pc, #28]	; (8001e40 <event_timer_set_period+0x24>)
 8001e24:	0049      	lsls	r1, r1, #1
 8001e26:	b289      	uxth	r1, r1
 8001e28:	f823 1010 	strh.w	r1, [r3, r0, lsl #1]
 8001e2c:	4b05      	ldr	r3, [pc, #20]	; (8001e44 <event_timer_set_period+0x28>)
 8001e2e:	f823 1010 	strh.w	r1, [r3, r0, lsl #1]
 8001e32:	4b05      	ldr	r3, [pc, #20]	; (8001e48 <event_timer_set_period+0x2c>)
 8001e34:	2200      	movs	r2, #0
 8001e36:	f823 2010 	strh.w	r2, [r3, r0, lsl #1]
 8001e3a:	b662      	cpsie	i
 8001e3c:	4770      	bx	lr
 8001e3e:	bf00      	nop
 8001e40:	20000ca4 	.word	0x20000ca4
 8001e44:	20000c98 	.word	0x20000c98
 8001e48:	20000c90 	.word	0x20000c90

08001e4c <event_timer_wait>:
 8001e4c:	b510      	push	{r4, lr}
 8001e4e:	4604      	mov	r4, r0
 8001e50:	4a06      	ldr	r2, [pc, #24]	; (8001e6c <event_timer_wait+0x20>)
 8001e52:	f832 3014 	ldrh.w	r3, [r2, r4, lsl #1]
 8001e56:	b29b      	uxth	r3, r3
 8001e58:	b913      	cbnz	r3, 8001e60 <event_timer_wait+0x14>
 8001e5a:	f000 fc81 	bl	8002760 <sleep>
 8001e5e:	e7f7      	b.n	8001e50 <event_timer_wait+0x4>
 8001e60:	b672      	cpsid	i
 8001e62:	2300      	movs	r3, #0
 8001e64:	f822 3014 	strh.w	r3, [r2, r4, lsl #1]
 8001e68:	b662      	cpsie	i
 8001e6a:	bd10      	pop	{r4, pc}
 8001e6c:	20000c90 	.word	0x20000c90

08001e70 <RCC_GetClocksFreq>:
 8001e70:	e92d 41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
 8001e74:	4f9b      	ldr	r7, [pc, #620]	; (80020e4 <RCC_GetClocksFreq+0x274>)
 8001e76:	687b      	ldr	r3, [r7, #4]
 8001e78:	f003 030c 	and.w	r3, r3, #12
 8001e7c:	2b04      	cmp	r3, #4
 8001e7e:	d005      	beq.n	8001e8c <RCC_GetClocksFreq+0x1c>
 8001e80:	2b08      	cmp	r3, #8
 8001e82:	d006      	beq.n	8001e92 <RCC_GetClocksFreq+0x22>
 8001e84:	4a98      	ldr	r2, [pc, #608]	; (80020e8 <RCC_GetClocksFreq+0x278>)
 8001e86:	6002      	str	r2, [r0, #0]
 8001e88:	b9b3      	cbnz	r3, 8001eb8 <RCC_GetClocksFreq+0x48>
 8001e8a:	e016      	b.n	8001eba <RCC_GetClocksFreq+0x4a>
 8001e8c:	4b96      	ldr	r3, [pc, #600]	; (80020e8 <RCC_GetClocksFreq+0x278>)
 8001e8e:	6003      	str	r3, [r0, #0]
 8001e90:	e012      	b.n	8001eb8 <RCC_GetClocksFreq+0x48>
 8001e92:	687b      	ldr	r3, [r7, #4]
 8001e94:	6879      	ldr	r1, [r7, #4]
 8001e96:	f3c3 4383 	ubfx	r3, r3, #18, #4
 8001e9a:	1c9a      	adds	r2, r3, #2
 8001e9c:	03cb      	lsls	r3, r1, #15
 8001e9e:	bf49      	itett	mi
 8001ea0:	6afb      	ldrmi	r3, [r7, #44]	; 0x2c
 8001ea2:	4b92      	ldrpl	r3, [pc, #584]	; (80020ec <RCC_GetClocksFreq+0x27c>)
 8001ea4:	4990      	ldrmi	r1, [pc, #576]	; (80020e8 <RCC_GetClocksFreq+0x278>)
 8001ea6:	f003 030f 	andmi.w	r3, r3, #15
 8001eaa:	bf44      	itt	mi
 8001eac:	3301      	addmi	r3, #1
 8001eae:	fbb1 f3f3 	udivmi	r3, r1, r3
 8001eb2:	4353      	muls	r3, r2
 8001eb4:	6003      	str	r3, [r0, #0]
 8001eb6:	e000      	b.n	8001eba <RCC_GetClocksFreq+0x4a>
 8001eb8:	2300      	movs	r3, #0
 8001eba:	687a      	ldr	r2, [r7, #4]
 8001ebc:	4e8c      	ldr	r6, [pc, #560]	; (80020f0 <RCC_GetClocksFreq+0x280>)
 8001ebe:	f8df c234 	ldr.w	ip, [pc, #564]	; 80020f4 <RCC_GetClocksFreq+0x284>
 8001ec2:	f3c2 1203 	ubfx	r2, r2, #4, #4
 8001ec6:	5cb4      	ldrb	r4, [r6, r2]
 8001ec8:	6802      	ldr	r2, [r0, #0]
 8001eca:	b2e4      	uxtb	r4, r4
 8001ecc:	fa22 f104 	lsr.w	r1, r2, r4
 8001ed0:	6041      	str	r1, [r0, #4]
 8001ed2:	687d      	ldr	r5, [r7, #4]
 8001ed4:	f3c5 2502 	ubfx	r5, r5, #8, #3
 8001ed8:	5d75      	ldrb	r5, [r6, r5]
 8001eda:	fa21 fe05 	lsr.w	lr, r1, r5
 8001ede:	f8c0 e008 	str.w	lr, [r0, #8]
 8001ee2:	687d      	ldr	r5, [r7, #4]
 8001ee4:	f3c5 25c2 	ubfx	r5, r5, #11, #3
 8001ee8:	5d75      	ldrb	r5, [r6, r5]
 8001eea:	b2ed      	uxtb	r5, r5
 8001eec:	40e9      	lsrs	r1, r5
 8001eee:	60c1      	str	r1, [r0, #12]
 8001ef0:	6afe      	ldr	r6, [r7, #44]	; 0x2c
 8001ef2:	f3c6 1804 	ubfx	r8, r6, #4, #5
 8001ef6:	f008 060f 	and.w	r6, r8, #15
 8001efa:	f018 0f10 	tst.w	r8, #16
 8001efe:	f83c 6016 	ldrh.w	r6, [ip, r6, lsl #1]
 8001f02:	46e0      	mov	r8, ip
 8001f04:	b2b6      	uxth	r6, r6
 8001f06:	d004      	beq.n	8001f12 <RCC_GetClocksFreq+0xa2>
 8001f08:	b11e      	cbz	r6, 8001f12 <RCC_GetClocksFreq+0xa2>
 8001f0a:	fbb3 f6f6 	udiv	r6, r3, r6
 8001f0e:	6106      	str	r6, [r0, #16]
 8001f10:	e000      	b.n	8001f14 <RCC_GetClocksFreq+0xa4>
 8001f12:	6102      	str	r2, [r0, #16]
 8001f14:	6afe      	ldr	r6, [r7, #44]	; 0x2c
 8001f16:	f3c6 2c44 	ubfx	ip, r6, #9, #5
 8001f1a:	f00c 060f 	and.w	r6, ip, #15
 8001f1e:	f01c 0f10 	tst.w	ip, #16
 8001f22:	f838 6016 	ldrh.w	r6, [r8, r6, lsl #1]
 8001f26:	b2b6      	uxth	r6, r6
 8001f28:	d004      	beq.n	8001f34 <RCC_GetClocksFreq+0xc4>
 8001f2a:	b11e      	cbz	r6, 8001f34 <RCC_GetClocksFreq+0xc4>
 8001f2c:	fbb3 f6f6 	udiv	r6, r3, r6
 8001f30:	6146      	str	r6, [r0, #20]
 8001f32:	e000      	b.n	8001f36 <RCC_GetClocksFreq+0xc6>
 8001f34:	6142      	str	r2, [r0, #20]
 8001f36:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 8001f38:	06f6      	lsls	r6, r6, #27
 8001f3a:	bf5a      	itte	pl
 8001f3c:	4e6a      	ldrpl	r6, [pc, #424]	; (80020e8 <RCC_GetClocksFreq+0x278>)
 8001f3e:	6186      	strpl	r6, [r0, #24]
 8001f40:	6182      	strmi	r2, [r0, #24]
 8001f42:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 8001f44:	06b6      	lsls	r6, r6, #26
 8001f46:	bf5a      	itte	pl
 8001f48:	4e67      	ldrpl	r6, [pc, #412]	; (80020e8 <RCC_GetClocksFreq+0x278>)
 8001f4a:	61c6      	strpl	r6, [r0, #28]
 8001f4c:	61c2      	strmi	r2, [r0, #28]
 8001f4e:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 8001f50:	0676      	lsls	r6, r6, #25
 8001f52:	bf5a      	itte	pl
 8001f54:	4e64      	ldrpl	r6, [pc, #400]	; (80020e8 <RCC_GetClocksFreq+0x278>)
 8001f56:	6206      	strpl	r6, [r0, #32]
 8001f58:	6202      	strmi	r2, [r0, #32]
 8001f5a:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 8001f5c:	05f6      	lsls	r6, r6, #23
 8001f5e:	d506      	bpl.n	8001f6e <RCC_GetClocksFreq+0xfe>
 8001f60:	429a      	cmp	r2, r3
 8001f62:	d104      	bne.n	8001f6e <RCC_GetClocksFreq+0xfe>
 8001f64:	42a5      	cmp	r5, r4
 8001f66:	d102      	bne.n	8001f6e <RCC_GetClocksFreq+0xfe>
 8001f68:	0056      	lsls	r6, r2, #1
 8001f6a:	6246      	str	r6, [r0, #36]	; 0x24
 8001f6c:	e000      	b.n	8001f70 <RCC_GetClocksFreq+0x100>
 8001f6e:	6241      	str	r1, [r0, #36]	; 0x24
 8001f70:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 8001f72:	04f6      	lsls	r6, r6, #19
 8001f74:	d506      	bpl.n	8001f84 <RCC_GetClocksFreq+0x114>
 8001f76:	429a      	cmp	r2, r3
 8001f78:	d104      	bne.n	8001f84 <RCC_GetClocksFreq+0x114>
 8001f7a:	42a5      	cmp	r5, r4
 8001f7c:	d102      	bne.n	8001f84 <RCC_GetClocksFreq+0x114>
 8001f7e:	0056      	lsls	r6, r2, #1
 8001f80:	6286      	str	r6, [r0, #40]	; 0x28
 8001f82:	e000      	b.n	8001f86 <RCC_GetClocksFreq+0x116>
 8001f84:	6281      	str	r1, [r0, #40]	; 0x28
 8001f86:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 8001f88:	05b6      	lsls	r6, r6, #22
 8001f8a:	d506      	bpl.n	8001f9a <RCC_GetClocksFreq+0x12a>
 8001f8c:	429a      	cmp	r2, r3
 8001f8e:	d104      	bne.n	8001f9a <RCC_GetClocksFreq+0x12a>
 8001f90:	42a5      	cmp	r5, r4
 8001f92:	d102      	bne.n	8001f9a <RCC_GetClocksFreq+0x12a>
 8001f94:	0056      	lsls	r6, r2, #1
 8001f96:	62c6      	str	r6, [r0, #44]	; 0x2c
 8001f98:	e000      	b.n	8001f9c <RCC_GetClocksFreq+0x12c>
 8001f9a:	62c1      	str	r1, [r0, #44]	; 0x2c
 8001f9c:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 8001f9e:	0576      	lsls	r6, r6, #21
 8001fa0:	d506      	bpl.n	8001fb0 <RCC_GetClocksFreq+0x140>
 8001fa2:	429a      	cmp	r2, r3
 8001fa4:	d104      	bne.n	8001fb0 <RCC_GetClocksFreq+0x140>
 8001fa6:	42a5      	cmp	r5, r4
 8001fa8:	d102      	bne.n	8001fb0 <RCC_GetClocksFreq+0x140>
 8001faa:	0056      	lsls	r6, r2, #1
 8001fac:	64c6      	str	r6, [r0, #76]	; 0x4c
 8001fae:	e000      	b.n	8001fb2 <RCC_GetClocksFreq+0x142>
 8001fb0:	64c1      	str	r1, [r0, #76]	; 0x4c
 8001fb2:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 8001fb4:	0536      	lsls	r6, r6, #20
 8001fb6:	d506      	bpl.n	8001fc6 <RCC_GetClocksFreq+0x156>
 8001fb8:	429a      	cmp	r2, r3
 8001fba:	d104      	bne.n	8001fc6 <RCC_GetClocksFreq+0x156>
 8001fbc:	42a5      	cmp	r5, r4
 8001fbe:	d102      	bne.n	8001fc6 <RCC_GetClocksFreq+0x156>
 8001fc0:	0056      	lsls	r6, r2, #1
 8001fc2:	6506      	str	r6, [r0, #80]	; 0x50
 8001fc4:	e000      	b.n	8001fc8 <RCC_GetClocksFreq+0x158>
 8001fc6:	6501      	str	r1, [r0, #80]	; 0x50
 8001fc8:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 8001fca:	04b6      	lsls	r6, r6, #18
 8001fcc:	d506      	bpl.n	8001fdc <RCC_GetClocksFreq+0x16c>
 8001fce:	429a      	cmp	r2, r3
 8001fd0:	d104      	bne.n	8001fdc <RCC_GetClocksFreq+0x16c>
 8001fd2:	42a5      	cmp	r5, r4
 8001fd4:	d102      	bne.n	8001fdc <RCC_GetClocksFreq+0x16c>
 8001fd6:	0056      	lsls	r6, r2, #1
 8001fd8:	6546      	str	r6, [r0, #84]	; 0x54
 8001fda:	e000      	b.n	8001fde <RCC_GetClocksFreq+0x16e>
 8001fdc:	6501      	str	r1, [r0, #80]	; 0x50
 8001fde:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 8001fe0:	0436      	lsls	r6, r6, #16
 8001fe2:	d506      	bpl.n	8001ff2 <RCC_GetClocksFreq+0x182>
 8001fe4:	429a      	cmp	r2, r3
 8001fe6:	d104      	bne.n	8001ff2 <RCC_GetClocksFreq+0x182>
 8001fe8:	42a5      	cmp	r5, r4
 8001fea:	d102      	bne.n	8001ff2 <RCC_GetClocksFreq+0x182>
 8001fec:	0053      	lsls	r3, r2, #1
 8001fee:	6583      	str	r3, [r0, #88]	; 0x58
 8001ff0:	e000      	b.n	8001ff4 <RCC_GetClocksFreq+0x184>
 8001ff2:	6581      	str	r1, [r0, #88]	; 0x58
 8001ff4:	6b3c      	ldr	r4, [r7, #48]	; 0x30
 8001ff6:	4b3b      	ldr	r3, [pc, #236]	; (80020e4 <RCC_GetClocksFreq+0x274>)
 8001ff8:	07a4      	lsls	r4, r4, #30
 8001ffa:	d101      	bne.n	8002000 <RCC_GetClocksFreq+0x190>
 8001ffc:	6381      	str	r1, [r0, #56]	; 0x38
 8001ffe:	e015      	b.n	800202c <RCC_GetClocksFreq+0x1bc>
 8002000:	6b19      	ldr	r1, [r3, #48]	; 0x30
 8002002:	f001 0103 	and.w	r1, r1, #3
 8002006:	2901      	cmp	r1, #1
 8002008:	d101      	bne.n	800200e <RCC_GetClocksFreq+0x19e>
 800200a:	6382      	str	r2, [r0, #56]	; 0x38
 800200c:	e00e      	b.n	800202c <RCC_GetClocksFreq+0x1bc>
 800200e:	6b19      	ldr	r1, [r3, #48]	; 0x30
 8002010:	f001 0103 	and.w	r1, r1, #3
 8002014:	2902      	cmp	r1, #2
 8002016:	d102      	bne.n	800201e <RCC_GetClocksFreq+0x1ae>
 8002018:	f44f 4300 	mov.w	r3, #32768	; 0x8000
 800201c:	e005      	b.n	800202a <RCC_GetClocksFreq+0x1ba>
 800201e:	6b1b      	ldr	r3, [r3, #48]	; 0x30
 8002020:	f003 0303 	and.w	r3, r3, #3
 8002024:	2b03      	cmp	r3, #3
 8002026:	d101      	bne.n	800202c <RCC_GetClocksFreq+0x1bc>
 8002028:	4b2f      	ldr	r3, [pc, #188]	; (80020e8 <RCC_GetClocksFreq+0x278>)
 800202a:	6383      	str	r3, [r0, #56]	; 0x38
 800202c:	6b39      	ldr	r1, [r7, #48]	; 0x30
 800202e:	4b2d      	ldr	r3, [pc, #180]	; (80020e4 <RCC_GetClocksFreq+0x274>)
 8002030:	f411 3f40 	tst.w	r1, #196608	; 0x30000
 8002034:	d102      	bne.n	800203c <RCC_GetClocksFreq+0x1cc>
 8002036:	f8c0 e03c 	str.w	lr, [r0, #60]	; 0x3c
 800203a:	e018      	b.n	800206e <RCC_GetClocksFreq+0x1fe>
 800203c:	6b19      	ldr	r1, [r3, #48]	; 0x30
 800203e:	f401 3140 	and.w	r1, r1, #196608	; 0x30000
 8002042:	f5b1 3f80 	cmp.w	r1, #65536	; 0x10000
 8002046:	d101      	bne.n	800204c <RCC_GetClocksFreq+0x1dc>
 8002048:	63c2      	str	r2, [r0, #60]	; 0x3c
 800204a:	e010      	b.n	800206e <RCC_GetClocksFreq+0x1fe>
 800204c:	6b19      	ldr	r1, [r3, #48]	; 0x30
 800204e:	f401 3140 	and.w	r1, r1, #196608	; 0x30000
 8002052:	f5b1 3f00 	cmp.w	r1, #131072	; 0x20000
 8002056:	d102      	bne.n	800205e <RCC_GetClocksFreq+0x1ee>
 8002058:	f44f 4300 	mov.w	r3, #32768	; 0x8000
 800205c:	e006      	b.n	800206c <RCC_GetClocksFreq+0x1fc>
 800205e:	6b1b      	ldr	r3, [r3, #48]	; 0x30
 8002060:	f403 3340 	and.w	r3, r3, #196608	; 0x30000
 8002064:	f5b3 3f40 	cmp.w	r3, #196608	; 0x30000
 8002068:	d101      	bne.n	800206e <RCC_GetClocksFreq+0x1fe>
 800206a:	4b1f      	ldr	r3, [pc, #124]	; (80020e8 <RCC_GetClocksFreq+0x278>)
 800206c:	63c3      	str	r3, [r0, #60]	; 0x3c
 800206e:	6b39      	ldr	r1, [r7, #48]	; 0x30
 8002070:	4b1c      	ldr	r3, [pc, #112]	; (80020e4 <RCC_GetClocksFreq+0x274>)
 8002072:	f411 2f40 	tst.w	r1, #786432	; 0xc0000
 8002076:	d102      	bne.n	800207e <RCC_GetClocksFreq+0x20e>
 8002078:	f8c0 e040 	str.w	lr, [r0, #64]	; 0x40
 800207c:	e018      	b.n	80020b0 <RCC_GetClocksFreq+0x240>
 800207e:	6b19      	ldr	r1, [r3, #48]	; 0x30
 8002080:	f401 2140 	and.w	r1, r1, #786432	; 0xc0000
 8002084:	f5b1 2f80 	cmp.w	r1, #262144	; 0x40000
 8002088:	d101      	bne.n	800208e <RCC_GetClocksFreq+0x21e>
 800208a:	6402      	str	r2, [r0, #64]	; 0x40
 800208c:	e010      	b.n	80020b0 <RCC_GetClocksFreq+0x240>
 800208e:	6b19      	ldr	r1, [r3, #48]	; 0x30
 8002090:	f401 2140 	and.w	r1, r1, #786432	; 0xc0000
 8002094:	f5b1 2f00 	cmp.w	r1, #524288	; 0x80000
 8002098:	d102      	bne.n	80020a0 <RCC_GetClocksFreq+0x230>
 800209a:	f44f 4300 	mov.w	r3, #32768	; 0x8000
 800209e:	e006      	b.n	80020ae <RCC_GetClocksFreq+0x23e>
 80020a0:	6b1b      	ldr	r3, [r3, #48]	; 0x30
 80020a2:	f403 2340 	and.w	r3, r3, #786432	; 0xc0000
 80020a6:	f5b3 2f40 	cmp.w	r3, #786432	; 0xc0000
 80020aa:	d101      	bne.n	80020b0 <RCC_GetClocksFreq+0x240>
 80020ac:	4b0e      	ldr	r3, [pc, #56]	; (80020e8 <RCC_GetClocksFreq+0x278>)
 80020ae:	6403      	str	r3, [r0, #64]	; 0x40
 80020b0:	6b39      	ldr	r1, [r7, #48]	; 0x30
 80020b2:	4b0c      	ldr	r3, [pc, #48]	; (80020e4 <RCC_GetClocksFreq+0x274>)
 80020b4:	f411 1f40 	tst.w	r1, #3145728	; 0x300000
 80020b8:	d102      	bne.n	80020c0 <RCC_GetClocksFreq+0x250>
 80020ba:	f8c0 e044 	str.w	lr, [r0, #68]	; 0x44
 80020be:	e023      	b.n	8002108 <RCC_GetClocksFreq+0x298>
 80020c0:	6b19      	ldr	r1, [r3, #48]	; 0x30
 80020c2:	f401 1140 	and.w	r1, r1, #3145728	; 0x300000
 80020c6:	f5b1 1f80 	cmp.w	r1, #1048576	; 0x100000
 80020ca:	d101      	bne.n	80020d0 <RCC_GetClocksFreq+0x260>
 80020cc:	6442      	str	r2, [r0, #68]	; 0x44
 80020ce:	e01b      	b.n	8002108 <RCC_GetClocksFreq+0x298>
 80020d0:	6b19      	ldr	r1, [r3, #48]	; 0x30
 80020d2:	f401 1140 	and.w	r1, r1, #3145728	; 0x300000
 80020d6:	f5b1 1f00 	cmp.w	r1, #2097152	; 0x200000
 80020da:	d10d      	bne.n	80020f8 <RCC_GetClocksFreq+0x288>
 80020dc:	f44f 4300 	mov.w	r3, #32768	; 0x8000
 80020e0:	e011      	b.n	8002106 <RCC_GetClocksFreq+0x296>
 80020e2:	bf00      	nop
 80020e4:	40021000 	.word	0x40021000
 80020e8:	007a1200 	.word	0x007a1200
 80020ec:	003d0900 	.word	0x003d0900
 80020f0:	20000020 	.word	0x20000020
 80020f4:	20000000 	.word	0x20000000
 80020f8:	6b1b      	ldr	r3, [r3, #48]	; 0x30
 80020fa:	f403 1340 	and.w	r3, r3, #3145728	; 0x300000
 80020fe:	f5b3 1f40 	cmp.w	r3, #3145728	; 0x300000
 8002102:	d101      	bne.n	8002108 <RCC_GetClocksFreq+0x298>
 8002104:	4b13      	ldr	r3, [pc, #76]	; (8002154 <RCC_GetClocksFreq+0x2e4>)
 8002106:	6443      	str	r3, [r0, #68]	; 0x44
 8002108:	6b39      	ldr	r1, [r7, #48]	; 0x30
 800210a:	4b13      	ldr	r3, [pc, #76]	; (8002158 <RCC_GetClocksFreq+0x2e8>)
 800210c:	f411 0f40 	tst.w	r1, #12582912	; 0xc00000
 8002110:	d103      	bne.n	800211a <RCC_GetClocksFreq+0x2aa>
 8002112:	f8c0 e048 	str.w	lr, [r0, #72]	; 0x48
 8002116:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
 800211a:	6b19      	ldr	r1, [r3, #48]	; 0x30
 800211c:	f401 0140 	and.w	r1, r1, #12582912	; 0xc00000
 8002120:	f5b1 0f80 	cmp.w	r1, #4194304	; 0x400000
 8002124:	d102      	bne.n	800212c <RCC_GetClocksFreq+0x2bc>
 8002126:	6482      	str	r2, [r0, #72]	; 0x48
 8002128:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
 800212c:	6b1a      	ldr	r2, [r3, #48]	; 0x30
 800212e:	f402 0240 	and.w	r2, r2, #12582912	; 0xc00000
 8002132:	f5b2 0f00 	cmp.w	r2, #8388608	; 0x800000
 8002136:	d102      	bne.n	800213e <RCC_GetClocksFreq+0x2ce>
 8002138:	f44f 4300 	mov.w	r3, #32768	; 0x8000
 800213c:	e006      	b.n	800214c <RCC_GetClocksFreq+0x2dc>
 800213e:	6b1b      	ldr	r3, [r3, #48]	; 0x30
 8002140:	f403 0340 	and.w	r3, r3, #12582912	; 0xc00000
 8002144:	f5b3 0f40 	cmp.w	r3, #12582912	; 0xc00000
 8002148:	d101      	bne.n	800214e <RCC_GetClocksFreq+0x2de>
 800214a:	4b02      	ldr	r3, [pc, #8]	; (8002154 <RCC_GetClocksFreq+0x2e4>)
 800214c:	6483      	str	r3, [r0, #72]	; 0x48
 800214e:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
 8002152:	bf00      	nop
 8002154:	007a1200 	.word	0x007a1200
 8002158:	40021000 	.word	0x40021000

0800215c <RCC_ADCCLKConfig>:
 800215c:	bf00      	nop
 800215e:	0f03      	lsrs	r3, r0, #28
 8002160:	4b05      	ldr	r3, [pc, #20]	; (8002178 <RCC_ADCCLKConfig+0x1c>)
 8002162:	6ada      	ldr	r2, [r3, #44]	; 0x2c
 8002164:	bf14      	ite	ne
 8002166:	f422 5278 	bicne.w	r2, r2, #15872	; 0x3e00
 800216a:	f422 72f8 	biceq.w	r2, r2, #496	; 0x1f0
 800216e:	62da      	str	r2, [r3, #44]	; 0x2c
 8002170:	6ada      	ldr	r2, [r3, #44]	; 0x2c
 8002172:	4310      	orrs	r0, r2
 8002174:	62d8      	str	r0, [r3, #44]	; 0x2c
 8002176:	4770      	bx	lr
 8002178:	40021000 	.word	0x40021000

0800217c <RCC_AHBPeriphClockCmd>:
 800217c:	bf00      	nop
 800217e:	bf00      	nop
 8002180:	4b04      	ldr	r3, [pc, #16]	; (8002194 <RCC_AHBPeriphClockCmd+0x18>)
 8002182:	695a      	ldr	r2, [r3, #20]
 8002184:	b109      	cbz	r1, 800218a <RCC_AHBPeriphClockCmd+0xe>
 8002186:	4310      	orrs	r0, r2
 8002188:	e001      	b.n	800218e <RCC_AHBPeriphClockCmd+0x12>
 800218a:	ea22 0000 	bic.w	r0, r2, r0
 800218e:	6158      	str	r0, [r3, #20]
 8002190:	4770      	bx	lr
 8002192:	bf00      	nop
 8002194:	40021000 	.word	0x40021000

08002198 <RCC_APB2PeriphClockCmd>:
 8002198:	bf00      	nop
 800219a:	bf00      	nop
 800219c:	4b04      	ldr	r3, [pc, #16]	; (80021b0 <RCC_APB2PeriphClockCmd+0x18>)
 800219e:	699a      	ldr	r2, [r3, #24]
 80021a0:	b109      	cbz	r1, 80021a6 <RCC_APB2PeriphClockCmd+0xe>
 80021a2:	4310      	orrs	r0, r2
 80021a4:	e001      	b.n	80021aa <RCC_APB2PeriphClockCmd+0x12>
 80021a6:	ea22 0000 	bic.w	r0, r2, r0
 80021aa:	6198      	str	r0, [r3, #24]
 80021ac:	4770      	bx	lr
 80021ae:	bf00      	nop
 80021b0:	40021000 	.word	0x40021000

080021b4 <RCC_APB1PeriphClockCmd>:
 80021b4:	bf00      	nop
 80021b6:	bf00      	nop
 80021b8:	4b04      	ldr	r3, [pc, #16]	; (80021cc <RCC_APB1PeriphClockCmd+0x18>)
 80021ba:	69da      	ldr	r2, [r3, #28]
 80021bc:	b109      	cbz	r1, 80021c2 <RCC_APB1PeriphClockCmd+0xe>
 80021be:	4310      	orrs	r0, r2
 80021c0:	e001      	b.n	80021c6 <RCC_APB1PeriphClockCmd+0x12>
 80021c2:	ea22 0000 	bic.w	r0, r2, r0
 80021c6:	61d8      	str	r0, [r3, #28]
 80021c8:	4770      	bx	lr
 80021ca:	bf00      	nop
 80021cc:	40021000 	.word	0x40021000

080021d0 <adc_init>:
 80021d0:	b530      	push	{r4, r5, lr}
 80021d2:	b08b      	sub	sp, #44	; 0x2c
 80021d4:	2400      	movs	r4, #0
 80021d6:	2303      	movs	r3, #3
 80021d8:	4669      	mov	r1, sp
 80021da:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 80021de:	f88d 3004 	strb.w	r3, [sp, #4]
 80021e2:	9400      	str	r4, [sp, #0]
 80021e4:	f88d 4007 	strb.w	r4, [sp, #7]
 80021e8:	f000 fbd6 	bl	8002998 <GPIO_Init>
 80021ec:	f44f 7088 	mov.w	r0, #272	; 0x110
 80021f0:	f7ff ffb4 	bl	800215c <RCC_ADCCLKConfig>
 80021f4:	f04f 5080 	mov.w	r0, #268435456	; 0x10000000
 80021f8:	2101      	movs	r1, #1
 80021fa:	f7ff ffbf 	bl	800217c <RCC_AHBPeriphClockCmd>
 80021fe:	2501      	movs	r5, #1
 8002200:	a902      	add	r1, sp, #8
 8002202:	f04f 40a0 	mov.w	r0, #1342177280	; 0x50000000
 8002206:	9408      	str	r4, [sp, #32]
 8002208:	9402      	str	r4, [sp, #8]
 800220a:	9406      	str	r4, [sp, #24]
 800220c:	9404      	str	r4, [sp, #16]
 800220e:	9405      	str	r4, [sp, #20]
 8002210:	f88d 5024 	strb.w	r5, [sp, #36]	; 0x24
 8002214:	9407      	str	r4, [sp, #28]
 8002216:	9403      	str	r4, [sp, #12]
 8002218:	f000 f83c 	bl	8002294 <ADC_Init>
 800221c:	462a      	mov	r2, r5
 800221e:	2304      	movs	r3, #4
 8002220:	f04f 40a0 	mov.w	r0, #1342177280	; 0x50000000
 8002224:	2102      	movs	r1, #2
 8002226:	f000 f86c 	bl	8002302 <ADC_RegularChannelConfig>
 800222a:	4629      	mov	r1, r5
 800222c:	f04f 40a0 	mov.w	r0, #1342177280	; 0x50000000
 8002230:	f000 f856 	bl	80022e0 <ADC_Cmd>
 8002234:	f04f 40a0 	mov.w	r0, #1342177280	; 0x50000000
 8002238:	f000 f85d 	bl	80022f6 <ADC_StartCalibration>
 800223c:	b00b      	add	sp, #44	; 0x2c
 800223e:	bd30      	pop	{r4, r5, pc}

08002240 <adc_read>:
 8002240:	3801      	subs	r0, #1
 8002242:	2808      	cmp	r0, #8
 8002244:	bf98      	it	ls
 8002246:	4b11      	ldrls	r3, [pc, #68]	; (800228c <adc_read+0x4c>)
 8002248:	b510      	push	{r4, lr}
 800224a:	bf9b      	ittet	ls
 800224c:	f853 4020 	ldrls.w	r4, [r3, r0, lsl #2]
 8002250:	4b0f      	ldrls	r3, [pc, #60]	; (8002290 <adc_read+0x50>)
 8002252:	f04f 44a0 	movhi.w	r4, #1342177280	; 0x50000000
 8002256:	5c19      	ldrbls	r1, [r3, r0]
 8002258:	bf88      	it	hi
 800225a:	2101      	movhi	r1, #1
 800225c:	4620      	mov	r0, r4
 800225e:	2201      	movs	r2, #1
 8002260:	2304      	movs	r3, #4
 8002262:	f000 f84e 	bl	8002302 <ADC_RegularChannelConfig>
 8002266:	4620      	mov	r0, r4
 8002268:	f000 f845 	bl	80022f6 <ADC_StartCalibration>
 800226c:	4620      	mov	r0, r4
 800226e:	f000 f8a6 	bl	80023be <ADC_StartConversion>
 8002272:	4620      	mov	r0, r4
 8002274:	2104      	movs	r1, #4
 8002276:	f000 f8ac 	bl	80023d2 <ADC_GetFlagStatus>
 800227a:	b908      	cbnz	r0, 8002280 <adc_read+0x40>
 800227c:	bf00      	nop
 800227e:	e7f8      	b.n	8002272 <adc_read+0x32>
 8002280:	4620      	mov	r0, r4
 8002282:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
 8002286:	f000 b8a0 	b.w	80023ca <ADC_GetConversionValue>
 800228a:	bf00      	nop
 800228c:	08002e44 	.word	0x08002e44
 8002290:	08002e68 	.word	0x08002e68

08002294 <ADC_Init>:
 8002294:	b510      	push	{r4, lr}
 8002296:	bf00      	nop
 8002298:	bf00      	nop
 800229a:	bf00      	nop
 800229c:	bf00      	nop
 800229e:	bf00      	nop
 80022a0:	bf00      	nop
 80022a2:	bf00      	nop
 80022a4:	bf00      	nop
 80022a6:	bf00      	nop
 80022a8:	4b0c      	ldr	r3, [pc, #48]	; (80022dc <ADC_Init+0x48>)
 80022aa:	68c2      	ldr	r2, [r0, #12]
 80022ac:	4013      	ands	r3, r2
 80022ae:	e891 0014 	ldmia.w	r1, {r2, r4}
 80022b2:	4314      	orrs	r4, r2
 80022b4:	688a      	ldr	r2, [r1, #8]
 80022b6:	4314      	orrs	r4, r2
 80022b8:	68ca      	ldr	r2, [r1, #12]
 80022ba:	4314      	orrs	r4, r2
 80022bc:	690a      	ldr	r2, [r1, #16]
 80022be:	4314      	orrs	r4, r2
 80022c0:	694a      	ldr	r2, [r1, #20]
 80022c2:	4314      	orrs	r4, r2
 80022c4:	698a      	ldr	r2, [r1, #24]
 80022c6:	4322      	orrs	r2, r4
 80022c8:	4313      	orrs	r3, r2
 80022ca:	60c3      	str	r3, [r0, #12]
 80022cc:	6b03      	ldr	r3, [r0, #48]	; 0x30
 80022ce:	f023 020f 	bic.w	r2, r3, #15
 80022d2:	7f0b      	ldrb	r3, [r1, #28]
 80022d4:	3b01      	subs	r3, #1
 80022d6:	4313      	orrs	r3, r2
 80022d8:	6303      	str	r3, [r0, #48]	; 0x30
 80022da:	bd10      	pop	{r4, pc}
 80022dc:	fdffc007 	.word	0xfdffc007

080022e0 <ADC_Cmd>:
 80022e0:	bf00      	nop
 80022e2:	bf00      	nop
 80022e4:	6883      	ldr	r3, [r0, #8]
 80022e6:	b111      	cbz	r1, 80022ee <ADC_Cmd+0xe>
 80022e8:	f043 0301 	orr.w	r3, r3, #1
 80022ec:	e001      	b.n	80022f2 <ADC_Cmd+0x12>
 80022ee:	f043 0302 	orr.w	r3, r3, #2
 80022f2:	6083      	str	r3, [r0, #8]
 80022f4:	4770      	bx	lr

080022f6 <ADC_StartCalibration>:
 80022f6:	bf00      	nop
 80022f8:	6883      	ldr	r3, [r0, #8]
 80022fa:	f043 4300 	orr.w	r3, r3, #2147483648	; 0x80000000
 80022fe:	6083      	str	r3, [r0, #8]
 8002300:	4770      	bx	lr

08002302 <ADC_RegularChannelConfig>:
 8002302:	b530      	push	{r4, r5, lr}
 8002304:	bf00      	nop
 8002306:	bf00      	nop
 8002308:	bf00      	nop
 800230a:	2a04      	cmp	r2, #4
 800230c:	d80c      	bhi.n	8002328 <ADC_RegularChannelConfig+0x26>
 800230e:	eb02 0242 	add.w	r2, r2, r2, lsl #1
 8002312:	6b05      	ldr	r5, [r0, #48]	; 0x30
 8002314:	0052      	lsls	r2, r2, #1
 8002316:	241f      	movs	r4, #31
 8002318:	4094      	lsls	r4, r2
 800231a:	ea25 0404 	bic.w	r4, r5, r4
 800231e:	fa01 f202 	lsl.w	r2, r1, r2
 8002322:	4322      	orrs	r2, r4
 8002324:	6302      	str	r2, [r0, #48]	; 0x30
 8002326:	e029      	b.n	800237c <ADC_RegularChannelConfig+0x7a>
 8002328:	2a09      	cmp	r2, #9
 800232a:	d80c      	bhi.n	8002346 <ADC_RegularChannelConfig+0x44>
 800232c:	2406      	movs	r4, #6
 800232e:	3a05      	subs	r2, #5
 8002330:	4362      	muls	r2, r4
 8002332:	6b45      	ldr	r5, [r0, #52]	; 0x34
 8002334:	241f      	movs	r4, #31
 8002336:	4094      	lsls	r4, r2
 8002338:	ea25 0404 	bic.w	r4, r5, r4
 800233c:	fa01 f202 	lsl.w	r2, r1, r2
 8002340:	4322      	orrs	r2, r4
 8002342:	6342      	str	r2, [r0, #52]	; 0x34
 8002344:	e01a      	b.n	800237c <ADC_RegularChannelConfig+0x7a>
 8002346:	2a0e      	cmp	r2, #14
 8002348:	f04f 0406 	mov.w	r4, #6
 800234c:	d80b      	bhi.n	8002366 <ADC_RegularChannelConfig+0x64>
 800234e:	3a0a      	subs	r2, #10
 8002350:	4362      	muls	r2, r4
 8002352:	6b85      	ldr	r5, [r0, #56]	; 0x38
 8002354:	241f      	movs	r4, #31
 8002356:	4094      	lsls	r4, r2
 8002358:	ea25 0404 	bic.w	r4, r5, r4
 800235c:	fa01 f202 	lsl.w	r2, r1, r2
 8002360:	4322      	orrs	r2, r4
 8002362:	6382      	str	r2, [r0, #56]	; 0x38
 8002364:	e00a      	b.n	800237c <ADC_RegularChannelConfig+0x7a>
 8002366:	3a0f      	subs	r2, #15
 8002368:	4362      	muls	r2, r4
 800236a:	6bc5      	ldr	r5, [r0, #60]	; 0x3c
 800236c:	241f      	movs	r4, #31
 800236e:	4094      	lsls	r4, r2
 8002370:	ea25 0404 	bic.w	r4, r5, r4
 8002374:	fa01 f202 	lsl.w	r2, r1, r2
 8002378:	4322      	orrs	r2, r4
 800237a:	63c2      	str	r2, [r0, #60]	; 0x3c
 800237c:	2909      	cmp	r1, #9
 800237e:	d90e      	bls.n	800239e <ADC_RegularChannelConfig+0x9c>
 8002380:	390a      	subs	r1, #10
 8002382:	6982      	ldr	r2, [r0, #24]
 8002384:	6984      	ldr	r4, [r0, #24]
 8002386:	eb01 0141 	add.w	r1, r1, r1, lsl #1
 800238a:	2207      	movs	r2, #7
 800238c:	408a      	lsls	r2, r1
 800238e:	ea24 0202 	bic.w	r2, r4, r2
 8002392:	6182      	str	r2, [r0, #24]
 8002394:	6982      	ldr	r2, [r0, #24]
 8002396:	408b      	lsls	r3, r1
 8002398:	4313      	orrs	r3, r2
 800239a:	6183      	str	r3, [r0, #24]
 800239c:	bd30      	pop	{r4, r5, pc}
 800239e:	3901      	subs	r1, #1
 80023a0:	6942      	ldr	r2, [r0, #20]
 80023a2:	6944      	ldr	r4, [r0, #20]
 80023a4:	eb01 0141 	add.w	r1, r1, r1, lsl #1
 80023a8:	2238      	movs	r2, #56	; 0x38
 80023aa:	408a      	lsls	r2, r1
 80023ac:	ea24 0202 	bic.w	r2, r4, r2
 80023b0:	6142      	str	r2, [r0, #20]
 80023b2:	6942      	ldr	r2, [r0, #20]
 80023b4:	3103      	adds	r1, #3
 80023b6:	408b      	lsls	r3, r1
 80023b8:	4313      	orrs	r3, r2
 80023ba:	6143      	str	r3, [r0, #20]
 80023bc:	bd30      	pop	{r4, r5, pc}

080023be <ADC_StartConversion>:
 80023be:	bf00      	nop
 80023c0:	6883      	ldr	r3, [r0, #8]
 80023c2:	f043 0304 	orr.w	r3, r3, #4
 80023c6:	6083      	str	r3, [r0, #8]
 80023c8:	4770      	bx	lr

080023ca <ADC_GetConversionValue>:
 80023ca:	bf00      	nop
 80023cc:	6c00      	ldr	r0, [r0, #64]	; 0x40
 80023ce:	b280      	uxth	r0, r0
 80023d0:	4770      	bx	lr

080023d2 <ADC_GetFlagStatus>:
 80023d2:	bf00      	nop
 80023d4:	bf00      	nop
 80023d6:	6803      	ldr	r3, [r0, #0]
 80023d8:	4219      	tst	r1, r3
 80023da:	bf14      	ite	ne
 80023dc:	2001      	movne	r0, #1
 80023de:	2000      	moveq	r0, #0
 80023e0:	4770      	bx	lr
	...

080023e4 <USART_Init>:
 80023e4:	b530      	push	{r4, r5, lr}
 80023e6:	4604      	mov	r4, r0
 80023e8:	b099      	sub	sp, #100	; 0x64
 80023ea:	460d      	mov	r5, r1
 80023ec:	bf00      	nop
 80023ee:	bf00      	nop
 80023f0:	bf00      	nop
 80023f2:	bf00      	nop
 80023f4:	bf00      	nop
 80023f6:	bf00      	nop
 80023f8:	bf00      	nop
 80023fa:	6803      	ldr	r3, [r0, #0]
 80023fc:	f023 0301 	bic.w	r3, r3, #1
 8002400:	6003      	str	r3, [r0, #0]
 8002402:	6843      	ldr	r3, [r0, #4]
 8002404:	f423 5240 	bic.w	r2, r3, #12288	; 0x3000
 8002408:	688b      	ldr	r3, [r1, #8]
 800240a:	68c9      	ldr	r1, [r1, #12]
 800240c:	4313      	orrs	r3, r2
 800240e:	6043      	str	r3, [r0, #4]
 8002410:	686a      	ldr	r2, [r5, #4]
 8002412:	6803      	ldr	r3, [r0, #0]
 8002414:	4311      	orrs	r1, r2
 8002416:	692a      	ldr	r2, [r5, #16]
 8002418:	f423 53b0 	bic.w	r3, r3, #5632	; 0x1600
 800241c:	430a      	orrs	r2, r1
 800241e:	f023 030c 	bic.w	r3, r3, #12
 8002422:	4313      	orrs	r3, r2
 8002424:	6003      	str	r3, [r0, #0]
 8002426:	6883      	ldr	r3, [r0, #8]
 8002428:	f423 7240 	bic.w	r2, r3, #768	; 0x300
 800242c:	696b      	ldr	r3, [r5, #20]
 800242e:	4313      	orrs	r3, r2
 8002430:	6083      	str	r3, [r0, #8]
 8002432:	a801      	add	r0, sp, #4
 8002434:	f7ff fd1c 	bl	8001e70 <RCC_GetClocksFreq>
 8002438:	4b17      	ldr	r3, [pc, #92]	; (8002498 <USART_Init+0xb4>)
 800243a:	429c      	cmp	r4, r3
 800243c:	d101      	bne.n	8002442 <USART_Init+0x5e>
 800243e:	9b0f      	ldr	r3, [sp, #60]	; 0x3c
 8002440:	e00e      	b.n	8002460 <USART_Init+0x7c>
 8002442:	4b16      	ldr	r3, [pc, #88]	; (800249c <USART_Init+0xb8>)
 8002444:	429c      	cmp	r4, r3
 8002446:	d101      	bne.n	800244c <USART_Init+0x68>
 8002448:	9b10      	ldr	r3, [sp, #64]	; 0x40
 800244a:	e009      	b.n	8002460 <USART_Init+0x7c>
 800244c:	4b14      	ldr	r3, [pc, #80]	; (80024a0 <USART_Init+0xbc>)
 800244e:	429c      	cmp	r4, r3
 8002450:	d101      	bne.n	8002456 <USART_Init+0x72>
 8002452:	9b11      	ldr	r3, [sp, #68]	; 0x44
 8002454:	e004      	b.n	8002460 <USART_Init+0x7c>
 8002456:	4b13      	ldr	r3, [pc, #76]	; (80024a4 <USART_Init+0xc0>)
 8002458:	429c      	cmp	r4, r3
 800245a:	bf0c      	ite	eq
 800245c:	9b12      	ldreq	r3, [sp, #72]	; 0x48
 800245e:	9b13      	ldrne	r3, [sp, #76]	; 0x4c
 8002460:	6822      	ldr	r2, [r4, #0]
 8002462:	6829      	ldr	r1, [r5, #0]
 8002464:	f412 4f00 	tst.w	r2, #32768	; 0x8000
 8002468:	bf18      	it	ne
 800246a:	005b      	lslne	r3, r3, #1
 800246c:	fbb3 f2f1 	udiv	r2, r3, r1
 8002470:	fb01 3312 	mls	r3, r1, r2, r3
 8002474:	ebb3 0f51 	cmp.w	r3, r1, lsr #1
 8002478:	6823      	ldr	r3, [r4, #0]
 800247a:	bf28      	it	cs
 800247c:	3201      	addcs	r2, #1
 800247e:	041b      	lsls	r3, r3, #16
 8002480:	bf41      	itttt	mi
 8002482:	f64f 73f0 	movwmi	r3, #65520	; 0xfff0
 8002486:	f3c2 0142 	ubfxmi	r1, r2, #1, #3
 800248a:	4013      	andmi	r3, r2
 800248c:	ea41 0203 	orrmi.w	r2, r1, r3
 8002490:	b292      	uxth	r2, r2
 8002492:	81a2      	strh	r2, [r4, #12]
 8002494:	b019      	add	sp, #100	; 0x64
 8002496:	bd30      	pop	{r4, r5, pc}
 8002498:	40013800 	.word	0x40013800
 800249c:	40004400 	.word	0x40004400
 80024a0:	40004800 	.word	0x40004800
 80024a4:	40004c00 	.word	0x40004c00

080024a8 <USART_Cmd>:
 80024a8:	bf00      	nop
 80024aa:	bf00      	nop
 80024ac:	6803      	ldr	r3, [r0, #0]
 80024ae:	b111      	cbz	r1, 80024b6 <USART_Cmd+0xe>
 80024b0:	f043 0301 	orr.w	r3, r3, #1
 80024b4:	e001      	b.n	80024ba <USART_Cmd+0x12>
 80024b6:	f023 0301 	bic.w	r3, r3, #1
 80024ba:	6003      	str	r3, [r0, #0]
 80024bc:	4770      	bx	lr

080024be <USART_ReceiveData>:
 80024be:	bf00      	nop
 80024c0:	8c80      	ldrh	r0, [r0, #36]	; 0x24
 80024c2:	f3c0 0008 	ubfx	r0, r0, #0, #9
 80024c6:	4770      	bx	lr

080024c8 <USART_ITConfig>:
 80024c8:	b510      	push	{r4, lr}
 80024ca:	bf00      	nop
 80024cc:	bf00      	nop
 80024ce:	bf00      	nop
 80024d0:	f3c1 2407 	ubfx	r4, r1, #8, #8
 80024d4:	2301      	movs	r3, #1
 80024d6:	b2c9      	uxtb	r1, r1
 80024d8:	2c02      	cmp	r4, #2
 80024da:	fa03 f301 	lsl.w	r3, r3, r1
 80024de:	d101      	bne.n	80024e4 <USART_ITConfig+0x1c>
 80024e0:	3004      	adds	r0, #4
 80024e2:	e002      	b.n	80024ea <USART_ITConfig+0x22>
 80024e4:	2c03      	cmp	r4, #3
 80024e6:	bf08      	it	eq
 80024e8:	3008      	addeq	r0, #8
 80024ea:	b112      	cbz	r2, 80024f2 <USART_ITConfig+0x2a>
 80024ec:	6802      	ldr	r2, [r0, #0]
 80024ee:	4313      	orrs	r3, r2
 80024f0:	e002      	b.n	80024f8 <USART_ITConfig+0x30>
 80024f2:	6802      	ldr	r2, [r0, #0]
 80024f4:	ea22 0303 	bic.w	r3, r2, r3
 80024f8:	6003      	str	r3, [r0, #0]
 80024fa:	bd10      	pop	{r4, pc}

080024fc <USART_GetITStatus>:
 80024fc:	b510      	push	{r4, lr}
 80024fe:	bf00      	nop
 8002500:	bf00      	nop
 8002502:	f3c1 2207 	ubfx	r2, r1, #8, #8
 8002506:	b2cc      	uxtb	r4, r1
 8002508:	2301      	movs	r3, #1
 800250a:	2a01      	cmp	r2, #1
 800250c:	fa03 f304 	lsl.w	r3, r3, r4
 8002510:	d101      	bne.n	8002516 <USART_GetITStatus+0x1a>
 8002512:	6802      	ldr	r2, [r0, #0]
 8002514:	e003      	b.n	800251e <USART_GetITStatus+0x22>
 8002516:	2a02      	cmp	r2, #2
 8002518:	bf0c      	ite	eq
 800251a:	6842      	ldreq	r2, [r0, #4]
 800251c:	6882      	ldrne	r2, [r0, #8]
 800251e:	4013      	ands	r3, r2
 8002520:	69c2      	ldr	r2, [r0, #28]
 8002522:	b13b      	cbz	r3, 8002534 <USART_GetITStatus+0x38>
 8002524:	0c09      	lsrs	r1, r1, #16
 8002526:	2301      	movs	r3, #1
 8002528:	408b      	lsls	r3, r1
 800252a:	4213      	tst	r3, r2
 800252c:	bf14      	ite	ne
 800252e:	2001      	movne	r0, #1
 8002530:	2000      	moveq	r0, #0
 8002532:	bd10      	pop	{r4, pc}
 8002534:	4618      	mov	r0, r3
 8002536:	bd10      	pop	{r4, pc}

08002538 <USART_ClearITPendingBit>:
 8002538:	bf00      	nop
 800253a:	bf00      	nop
 800253c:	2301      	movs	r3, #1
 800253e:	0c09      	lsrs	r1, r1, #16
 8002540:	408b      	lsls	r3, r1
 8002542:	6203      	str	r3, [r0, #32]
 8002544:	4770      	bx	lr
	...

08002548 <uart_write>:
 8002548:	4b04      	ldr	r3, [pc, #16]	; (800255c <uart_write+0x14>)
 800254a:	69da      	ldr	r2, [r3, #28]
 800254c:	0612      	lsls	r2, r2, #24
 800254e:	d401      	bmi.n	8002554 <uart_write+0xc>
 8002550:	bf00      	nop
 8002552:	e7f9      	b.n	8002548 <uart_write>
 8002554:	b280      	uxth	r0, r0
 8002556:	8518      	strh	r0, [r3, #40]	; 0x28
 8002558:	4770      	bx	lr
 800255a:	bf00      	nop
 800255c:	40013800 	.word	0x40013800

08002560 <uart_is_char>:
 8002560:	4b0a      	ldr	r3, [pc, #40]	; (800258c <uart_is_char+0x2c>)
 8002562:	4a0b      	ldr	r2, [pc, #44]	; (8002590 <uart_is_char+0x30>)
 8002564:	6819      	ldr	r1, [r3, #0]
 8002566:	6812      	ldr	r2, [r2, #0]
 8002568:	4291      	cmp	r1, r2
 800256a:	d00b      	beq.n	8002584 <uart_is_char+0x24>
 800256c:	681a      	ldr	r2, [r3, #0]
 800256e:	4909      	ldr	r1, [pc, #36]	; (8002594 <uart_is_char+0x34>)
 8002570:	5c88      	ldrb	r0, [r1, r2]
 8002572:	681a      	ldr	r2, [r3, #0]
 8002574:	3201      	adds	r2, #1
 8002576:	601a      	str	r2, [r3, #0]
 8002578:	681a      	ldr	r2, [r3, #0]
 800257a:	2a0f      	cmp	r2, #15
 800257c:	d904      	bls.n	8002588 <uart_is_char+0x28>
 800257e:	2200      	movs	r2, #0
 8002580:	601a      	str	r2, [r3, #0]
 8002582:	4770      	bx	lr
 8002584:	f64f 70ff 	movw	r0, #65535	; 0xffff
 8002588:	4770      	bx	lr
 800258a:	bf00      	nop
 800258c:	20000cc0 	.word	0x20000cc0
 8002590:	20000cbc 	.word	0x20000cbc
 8002594:	20000cac 	.word	0x20000cac

08002598 <uart_init>:
 8002598:	b530      	push	{r4, r5, lr}
 800259a:	4b2c      	ldr	r3, [pc, #176]	; (800264c <uart_init+0xb4>)
 800259c:	4d2c      	ldr	r5, [pc, #176]	; (8002650 <uart_init+0xb8>)
 800259e:	2400      	movs	r4, #0
 80025a0:	601c      	str	r4, [r3, #0]
 80025a2:	4b2c      	ldr	r3, [pc, #176]	; (8002654 <uart_init+0xbc>)
 80025a4:	b08b      	sub	sp, #44	; 0x2c
 80025a6:	f44f 3000 	mov.w	r0, #131072	; 0x20000
 80025aa:	2101      	movs	r1, #1
 80025ac:	601c      	str	r4, [r3, #0]
 80025ae:	f7ff fde5 	bl	800217c <RCC_AHBPeriphClockCmd>
 80025b2:	f44f 4080 	mov.w	r0, #16384	; 0x4000
 80025b6:	2101      	movs	r1, #1
 80025b8:	f7ff fdee 	bl	8002198 <RCC_APB2PeriphClockCmd>
 80025bc:	f44f 63c0 	mov.w	r3, #1536	; 0x600
 80025c0:	9302      	str	r3, [sp, #8]
 80025c2:	2302      	movs	r3, #2
 80025c4:	f88d 300c 	strb.w	r3, [sp, #12]
 80025c8:	a902      	add	r1, sp, #8
 80025ca:	2303      	movs	r3, #3
 80025cc:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 80025d0:	f88d 300d 	strb.w	r3, [sp, #13]
 80025d4:	f88d 400e 	strb.w	r4, [sp, #14]
 80025d8:	f88d 400f 	strb.w	r4, [sp, #15]
 80025dc:	f000 f9dc 	bl	8002998 <GPIO_Init>
 80025e0:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 80025e4:	2109      	movs	r1, #9
 80025e6:	2207      	movs	r2, #7
 80025e8:	f000 fa20 	bl	8002a2c <GPIO_PinAFConfig>
 80025ec:	2207      	movs	r2, #7
 80025ee:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 80025f2:	210a      	movs	r1, #10
 80025f4:	f000 fa1a 	bl	8002a2c <GPIO_PinAFConfig>
 80025f8:	f44f 5316 	mov.w	r3, #9600	; 0x2580
 80025fc:	9304      	str	r3, [sp, #16]
 80025fe:	4628      	mov	r0, r5
 8002600:	230c      	movs	r3, #12
 8002602:	a904      	add	r1, sp, #16
 8002604:	9308      	str	r3, [sp, #32]
 8002606:	9405      	str	r4, [sp, #20]
 8002608:	9406      	str	r4, [sp, #24]
 800260a:	9407      	str	r4, [sp, #28]
 800260c:	9409      	str	r4, [sp, #36]	; 0x24
 800260e:	f7ff fee9 	bl	80023e4 <USART_Init>
 8002612:	4628      	mov	r0, r5
 8002614:	2101      	movs	r1, #1
 8002616:	f7ff ff47 	bl	80024a8 <USART_Cmd>
 800261a:	2201      	movs	r2, #1
 800261c:	4628      	mov	r0, r5
 800261e:	490e      	ldr	r1, [pc, #56]	; (8002658 <uart_init+0xc0>)
 8002620:	f7ff ff52 	bl	80024c8 <USART_ITConfig>
 8002624:	2325      	movs	r3, #37	; 0x25
 8002626:	f88d 4005 	strb.w	r4, [sp, #5]
 800262a:	f88d 4006 	strb.w	r4, [sp, #6]
 800262e:	a801      	add	r0, sp, #4
 8002630:	2401      	movs	r4, #1
 8002632:	f88d 3004 	strb.w	r3, [sp, #4]
 8002636:	f88d 4007 	strb.w	r4, [sp, #7]
 800263a:	f7ff fabb 	bl	8001bb4 <NVIC_Init>
 800263e:	4628      	mov	r0, r5
 8002640:	4621      	mov	r1, r4
 8002642:	f7ff ff31 	bl	80024a8 <USART_Cmd>
 8002646:	b00b      	add	sp, #44	; 0x2c
 8002648:	bd30      	pop	{r4, r5, pc}
 800264a:	bf00      	nop
 800264c:	20000cbc 	.word	0x20000cbc
 8002650:	40013800 	.word	0x40013800
 8002654:	20000cc0 	.word	0x20000cc0
 8002658:	00050105 	.word	0x00050105

0800265c <USART1_IRQHandler>:
 800265c:	b508      	push	{r3, lr}
 800265e:	480d      	ldr	r0, [pc, #52]	; (8002694 <USART1_IRQHandler+0x38>)
 8002660:	490d      	ldr	r1, [pc, #52]	; (8002698 <USART1_IRQHandler+0x3c>)
 8002662:	f7ff ff4b 	bl	80024fc <USART_GetITStatus>
 8002666:	b178      	cbz	r0, 8002688 <USART1_IRQHandler+0x2c>
 8002668:	480a      	ldr	r0, [pc, #40]	; (8002694 <USART1_IRQHandler+0x38>)
 800266a:	f7ff ff28 	bl	80024be <USART_ReceiveData>
 800266e:	4b0b      	ldr	r3, [pc, #44]	; (800269c <USART1_IRQHandler+0x40>)
 8002670:	490b      	ldr	r1, [pc, #44]	; (80026a0 <USART1_IRQHandler+0x44>)
 8002672:	681a      	ldr	r2, [r3, #0]
 8002674:	b2c0      	uxtb	r0, r0
 8002676:	5488      	strb	r0, [r1, r2]
 8002678:	681a      	ldr	r2, [r3, #0]
 800267a:	3201      	adds	r2, #1
 800267c:	601a      	str	r2, [r3, #0]
 800267e:	681a      	ldr	r2, [r3, #0]
 8002680:	2a0f      	cmp	r2, #15
 8002682:	bf84      	itt	hi
 8002684:	2200      	movhi	r2, #0
 8002686:	601a      	strhi	r2, [r3, #0]
 8002688:	4802      	ldr	r0, [pc, #8]	; (8002694 <USART1_IRQHandler+0x38>)
 800268a:	4903      	ldr	r1, [pc, #12]	; (8002698 <USART1_IRQHandler+0x3c>)
 800268c:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 8002690:	f7ff bf52 	b.w	8002538 <USART_ClearITPendingBit>
 8002694:	40013800 	.word	0x40013800
 8002698:	00050105 	.word	0x00050105
 800269c:	20000cbc 	.word	0x20000cbc
 80026a0:	20000cac 	.word	0x20000cac

080026a4 <uart_clear_buffer>:
 80026a4:	b672      	cpsid	i
 80026a6:	2300      	movs	r3, #0
 80026a8:	4a03      	ldr	r2, [pc, #12]	; (80026b8 <uart_clear_buffer+0x14>)
 80026aa:	2100      	movs	r1, #0
 80026ac:	54d1      	strb	r1, [r2, r3]
 80026ae:	3301      	adds	r3, #1
 80026b0:	2b10      	cmp	r3, #16
 80026b2:	d1f9      	bne.n	80026a8 <uart_clear_buffer+0x4>
 80026b4:	b662      	cpsie	i
 80026b6:	4770      	bx	lr
 80026b8:	20000cac 	.word	0x20000cac

080026bc <Default_Handler>:
 80026bc:	4668      	mov	r0, sp
 80026be:	f020 0107 	bic.w	r1, r0, #7
 80026c2:	468d      	mov	sp, r1
 80026c4:	bf00      	nop
 80026c6:	e7fd      	b.n	80026c4 <Default_Handler+0x8>

080026c8 <HardFault_Handler>:
 80026c8:	f44f 4000 	mov.w	r0, #32768	; 0x8000
 80026cc:	f000 f8ca 	bl	8002864 <led_on>
 80026d0:	4b06      	ldr	r3, [pc, #24]	; (80026ec <HardFault_Handler+0x24>)
 80026d2:	3b01      	subs	r3, #1
 80026d4:	d001      	beq.n	80026da <HardFault_Handler+0x12>
 80026d6:	bf00      	nop
 80026d8:	e7fb      	b.n	80026d2 <HardFault_Handler+0xa>
 80026da:	f44f 4000 	mov.w	r0, #32768	; 0x8000
 80026de:	f000 f8d7 	bl	8002890 <led_off>
 80026e2:	4b02      	ldr	r3, [pc, #8]	; (80026ec <HardFault_Handler+0x24>)
 80026e4:	3b01      	subs	r3, #1
 80026e6:	d0ef      	beq.n	80026c8 <HardFault_Handler>
 80026e8:	bf00      	nop
 80026ea:	e7fb      	b.n	80026e4 <HardFault_Handler+0x1c>
 80026ec:	00989681 	.word	0x00989681

080026f0 <_reset_init>:
 80026f0:	490e      	ldr	r1, [pc, #56]	; (800272c <_reset_init+0x3c>)
 80026f2:	4b0f      	ldr	r3, [pc, #60]	; (8002730 <_reset_init+0x40>)
 80026f4:	1a5b      	subs	r3, r3, r1
 80026f6:	109b      	asrs	r3, r3, #2
 80026f8:	2200      	movs	r2, #0
 80026fa:	429a      	cmp	r2, r3
 80026fc:	d006      	beq.n	800270c <_reset_init+0x1c>
 80026fe:	480d      	ldr	r0, [pc, #52]	; (8002734 <_reset_init+0x44>)
 8002700:	f850 0022 	ldr.w	r0, [r0, r2, lsl #2]
 8002704:	f841 0022 	str.w	r0, [r1, r2, lsl #2]
 8002708:	3201      	adds	r2, #1
 800270a:	e7f6      	b.n	80026fa <_reset_init+0xa>
 800270c:	4a0a      	ldr	r2, [pc, #40]	; (8002738 <_reset_init+0x48>)
 800270e:	f8d2 3088 	ldr.w	r3, [r2, #136]	; 0x88
 8002712:	f443 0370 	orr.w	r3, r3, #15728640	; 0xf00000
 8002716:	f8c2 3088 	str.w	r3, [r2, #136]	; 0x88
 800271a:	f502 720c 	add.w	r2, r2, #560	; 0x230
 800271e:	6853      	ldr	r3, [r2, #4]
 8002720:	f023 4340 	bic.w	r3, r3, #3221225472	; 0xc0000000
 8002724:	6053      	str	r3, [r2, #4]
 8002726:	f7fe bee3 	b.w	80014f0 <main>
 800272a:	bf00      	nop
 800272c:	20000000 	.word	0x20000000
 8002730:	20000030 	.word	0x20000030
 8002734:	08002e78 	.word	0x08002e78
 8002738:	e000ed00 	.word	0xe000ed00

0800273c <sys_tick_init>:
 800273c:	4b05      	ldr	r3, [pc, #20]	; (8002754 <sys_tick_init+0x18>)
 800273e:	4a06      	ldr	r2, [pc, #24]	; (8002758 <sys_tick_init+0x1c>)
 8002740:	605a      	str	r2, [r3, #4]
 8002742:	4a06      	ldr	r2, [pc, #24]	; (800275c <sys_tick_init+0x20>)
 8002744:	21f0      	movs	r1, #240	; 0xf0
 8002746:	f882 1023 	strb.w	r1, [r2, #35]	; 0x23
 800274a:	2200      	movs	r2, #0
 800274c:	609a      	str	r2, [r3, #8]
 800274e:	2207      	movs	r2, #7
 8002750:	601a      	str	r2, [r3, #0]
 8002752:	4770      	bx	lr
 8002754:	e000e010 	.word	0xe000e010
 8002758:	00029040 	.word	0x00029040
 800275c:	e000ed00 	.word	0xe000ed00

08002760 <sleep>:
 8002760:	bf30      	wfi
 8002762:	4770      	bx	lr

08002764 <sytem_clock_init>:
 8002764:	f000 b800 	b.w	8002768 <SystemInit>

08002768 <SystemInit>:
 8002768:	4a39      	ldr	r2, [pc, #228]	; (8002850 <SystemInit+0xe8>)
 800276a:	f8d2 3088 	ldr.w	r3, [r2, #136]	; 0x88
 800276e:	f443 0370 	orr.w	r3, r3, #15728640	; 0xf00000
 8002772:	f8c2 3088 	str.w	r3, [r2, #136]	; 0x88
 8002776:	4b37      	ldr	r3, [pc, #220]	; (8002854 <SystemInit+0xec>)
 8002778:	681a      	ldr	r2, [r3, #0]
 800277a:	f042 0201 	orr.w	r2, r2, #1
 800277e:	601a      	str	r2, [r3, #0]
 8002780:	6859      	ldr	r1, [r3, #4]
 8002782:	4a35      	ldr	r2, [pc, #212]	; (8002858 <SystemInit+0xf0>)
 8002784:	400a      	ands	r2, r1
 8002786:	605a      	str	r2, [r3, #4]
 8002788:	681a      	ldr	r2, [r3, #0]
 800278a:	f022 7284 	bic.w	r2, r2, #17301504	; 0x1080000
 800278e:	f422 3280 	bic.w	r2, r2, #65536	; 0x10000
 8002792:	601a      	str	r2, [r3, #0]
 8002794:	681a      	ldr	r2, [r3, #0]
 8002796:	f422 2280 	bic.w	r2, r2, #262144	; 0x40000
 800279a:	601a      	str	r2, [r3, #0]
 800279c:	685a      	ldr	r2, [r3, #4]
 800279e:	f422 02fe 	bic.w	r2, r2, #8323072	; 0x7f0000
 80027a2:	605a      	str	r2, [r3, #4]
 80027a4:	6ada      	ldr	r2, [r3, #44]	; 0x2c
 80027a6:	f022 020f 	bic.w	r2, r2, #15
 80027aa:	62da      	str	r2, [r3, #44]	; 0x2c
 80027ac:	6b19      	ldr	r1, [r3, #48]	; 0x30
 80027ae:	4a2b      	ldr	r2, [pc, #172]	; (800285c <SystemInit+0xf4>)
 80027b0:	b082      	sub	sp, #8
 80027b2:	400a      	ands	r2, r1
 80027b4:	631a      	str	r2, [r3, #48]	; 0x30
 80027b6:	2200      	movs	r2, #0
 80027b8:	609a      	str	r2, [r3, #8]
 80027ba:	9200      	str	r2, [sp, #0]
 80027bc:	9201      	str	r2, [sp, #4]
 80027be:	681a      	ldr	r2, [r3, #0]
 80027c0:	f442 3280 	orr.w	r2, r2, #65536	; 0x10000
 80027c4:	601a      	str	r2, [r3, #0]
 80027c6:	681a      	ldr	r2, [r3, #0]
 80027c8:	f402 3200 	and.w	r2, r2, #131072	; 0x20000
 80027cc:	9201      	str	r2, [sp, #4]
 80027ce:	9a00      	ldr	r2, [sp, #0]
 80027d0:	3201      	adds	r2, #1
 80027d2:	9200      	str	r2, [sp, #0]
 80027d4:	9a01      	ldr	r2, [sp, #4]
 80027d6:	b91a      	cbnz	r2, 80027e0 <SystemInit+0x78>
 80027d8:	9a00      	ldr	r2, [sp, #0]
 80027da:	f5b2 4fa0 	cmp.w	r2, #20480	; 0x5000
 80027de:	d1f2      	bne.n	80027c6 <SystemInit+0x5e>
 80027e0:	681a      	ldr	r2, [r3, #0]
 80027e2:	f412 3200 	ands.w	r2, r2, #131072	; 0x20000
 80027e6:	bf18      	it	ne
 80027e8:	2201      	movne	r2, #1
 80027ea:	9201      	str	r2, [sp, #4]
 80027ec:	9a01      	ldr	r2, [sp, #4]
 80027ee:	2a01      	cmp	r2, #1
 80027f0:	d005      	beq.n	80027fe <SystemInit+0x96>
 80027f2:	4b17      	ldr	r3, [pc, #92]	; (8002850 <SystemInit+0xe8>)
 80027f4:	f04f 6200 	mov.w	r2, #134217728	; 0x8000000
 80027f8:	609a      	str	r2, [r3, #8]
 80027fa:	b002      	add	sp, #8
 80027fc:	4770      	bx	lr
 80027fe:	4a18      	ldr	r2, [pc, #96]	; (8002860 <SystemInit+0xf8>)
 8002800:	2112      	movs	r1, #18
 8002802:	6011      	str	r1, [r2, #0]
 8002804:	685a      	ldr	r2, [r3, #4]
 8002806:	605a      	str	r2, [r3, #4]
 8002808:	685a      	ldr	r2, [r3, #4]
 800280a:	605a      	str	r2, [r3, #4]
 800280c:	685a      	ldr	r2, [r3, #4]
 800280e:	f442 6280 	orr.w	r2, r2, #1024	; 0x400
 8002812:	605a      	str	r2, [r3, #4]
 8002814:	685a      	ldr	r2, [r3, #4]
 8002816:	f422 127c 	bic.w	r2, r2, #4128768	; 0x3f0000
 800281a:	605a      	str	r2, [r3, #4]
 800281c:	685a      	ldr	r2, [r3, #4]
 800281e:	f442 12e8 	orr.w	r2, r2, #1900544	; 0x1d0000
 8002822:	605a      	str	r2, [r3, #4]
 8002824:	681a      	ldr	r2, [r3, #0]
 8002826:	f042 7280 	orr.w	r2, r2, #16777216	; 0x1000000
 800282a:	601a      	str	r2, [r3, #0]
 800282c:	6819      	ldr	r1, [r3, #0]
 800282e:	4a09      	ldr	r2, [pc, #36]	; (8002854 <SystemInit+0xec>)
 8002830:	0189      	lsls	r1, r1, #6
 8002832:	d5fb      	bpl.n	800282c <SystemInit+0xc4>
 8002834:	6851      	ldr	r1, [r2, #4]
 8002836:	f021 0103 	bic.w	r1, r1, #3
 800283a:	6051      	str	r1, [r2, #4]
 800283c:	6851      	ldr	r1, [r2, #4]
 800283e:	f041 0102 	orr.w	r1, r1, #2
 8002842:	6051      	str	r1, [r2, #4]
 8002844:	685a      	ldr	r2, [r3, #4]
 8002846:	f002 020c 	and.w	r2, r2, #12
 800284a:	2a08      	cmp	r2, #8
 800284c:	d1fa      	bne.n	8002844 <SystemInit+0xdc>
 800284e:	e7d0      	b.n	80027f2 <SystemInit+0x8a>
 8002850:	e000ed00 	.word	0xe000ed00
 8002854:	40021000 	.word	0x40021000
 8002858:	f87fc00c 	.word	0xf87fc00c
 800285c:	ff00fccc 	.word	0xff00fccc
 8002860:	40022000 	.word	0x40022000

08002864 <led_on>:
 8002864:	0401      	lsls	r1, r0, #16
 8002866:	bf42      	ittt	mi
 8002868:	4b08      	ldrmi	r3, [pc, #32]	; (800288c <led_on+0x28>)
 800286a:	f44f 4200 	movmi.w	r2, #32768	; 0x8000
 800286e:	619a      	strmi	r2, [r3, #24]
 8002870:	0702      	lsls	r2, r0, #28
 8002872:	bf42      	ittt	mi
 8002874:	f04f 4390 	movmi.w	r3, #1207959552	; 0x48000000
 8002878:	2208      	movmi	r2, #8
 800287a:	851a      	strhmi	r2, [r3, #40]	; 0x28
 800287c:	07c3      	lsls	r3, r0, #31
 800287e:	bf42      	ittt	mi
 8002880:	f04f 4390 	movmi.w	r3, #1207959552	; 0x48000000
 8002884:	2201      	movmi	r2, #1
 8002886:	619a      	strmi	r2, [r3, #24]
 8002888:	4770      	bx	lr
 800288a:	bf00      	nop
 800288c:	48000400 	.word	0x48000400

08002890 <led_off>:
 8002890:	0401      	lsls	r1, r0, #16
 8002892:	bf42      	ittt	mi
 8002894:	4b08      	ldrmi	r3, [pc, #32]	; (80028b8 <led_off+0x28>)
 8002896:	f44f 4200 	movmi.w	r2, #32768	; 0x8000
 800289a:	851a      	strhmi	r2, [r3, #40]	; 0x28
 800289c:	0702      	lsls	r2, r0, #28
 800289e:	bf42      	ittt	mi
 80028a0:	f04f 4390 	movmi.w	r3, #1207959552	; 0x48000000
 80028a4:	2208      	movmi	r2, #8
 80028a6:	619a      	strmi	r2, [r3, #24]
 80028a8:	07c3      	lsls	r3, r0, #31
 80028aa:	bf42      	ittt	mi
 80028ac:	f04f 4390 	movmi.w	r3, #1207959552	; 0x48000000
 80028b0:	2201      	movmi	r2, #1
 80028b2:	851a      	strhmi	r2, [r3, #40]	; 0x28
 80028b4:	4770      	bx	lr
 80028b6:	bf00      	nop
 80028b8:	48000400 	.word	0x48000400

080028bc <gpio_init>:
 80028bc:	e92d 41f3 	stmdb	sp!, {r0, r1, r4, r5, r6, r7, r8, lr}
 80028c0:	f44f 3000 	mov.w	r0, #131072	; 0x20000
 80028c4:	2101      	movs	r1, #1
 80028c6:	f7ff fc59 	bl	800217c <RCC_AHBPeriphClockCmd>
 80028ca:	f44f 2080 	mov.w	r0, #262144	; 0x40000
 80028ce:	2101      	movs	r1, #1
 80028d0:	f7ff fc54 	bl	800217c <RCC_AHBPeriphClockCmd>
 80028d4:	f44f 2000 	mov.w	r0, #524288	; 0x80000
 80028d8:	2101      	movs	r1, #1
 80028da:	f7ff fc4f 	bl	800217c <RCC_AHBPeriphClockCmd>
 80028de:	2400      	movs	r4, #0
 80028e0:	2501      	movs	r5, #1
 80028e2:	2603      	movs	r6, #3
 80028e4:	f44f 4800 	mov.w	r8, #32768	; 0x8000
 80028e8:	4826      	ldr	r0, [pc, #152]	; (8002984 <gpio_init+0xc8>)
 80028ea:	f8cd 8000 	str.w	r8, [sp]
 80028ee:	4669      	mov	r1, sp
 80028f0:	2708      	movs	r7, #8
 80028f2:	f88d 5004 	strb.w	r5, [sp, #4]
 80028f6:	f88d 4006 	strb.w	r4, [sp, #6]
 80028fa:	f88d 6005 	strb.w	r6, [sp, #5]
 80028fe:	f88d 4007 	strb.w	r4, [sp, #7]
 8002902:	f000 f849 	bl	8002998 <GPIO_Init>
 8002906:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 800290a:	4669      	mov	r1, sp
 800290c:	9700      	str	r7, [sp, #0]
 800290e:	f88d 5004 	strb.w	r5, [sp, #4]
 8002912:	f88d 4006 	strb.w	r4, [sp, #6]
 8002916:	f88d 6005 	strb.w	r6, [sp, #5]
 800291a:	f88d 4007 	strb.w	r4, [sp, #7]
 800291e:	f000 f83b 	bl	8002998 <GPIO_Init>
 8002922:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 8002926:	4669      	mov	r1, sp
 8002928:	9500      	str	r5, [sp, #0]
 800292a:	f88d 5004 	strb.w	r5, [sp, #4]
 800292e:	f88d 4006 	strb.w	r4, [sp, #6]
 8002932:	f88d 6005 	strb.w	r6, [sp, #5]
 8002936:	f88d 4007 	strb.w	r4, [sp, #7]
 800293a:	f000 f82d 	bl	8002998 <GPIO_Init>
 800293e:	f44f 7300 	mov.w	r3, #512	; 0x200
 8002942:	4669      	mov	r1, sp
 8002944:	480f      	ldr	r0, [pc, #60]	; (8002984 <gpio_init+0xc8>)
 8002946:	9300      	str	r3, [sp, #0]
 8002948:	f88d 4004 	strb.w	r4, [sp, #4]
 800294c:	f88d 6005 	strb.w	r6, [sp, #5]
 8002950:	f88d 4007 	strb.w	r4, [sp, #7]
 8002954:	f000 f820 	bl	8002998 <GPIO_Init>
 8002958:	4640      	mov	r0, r8
 800295a:	f7ff ff83 	bl	8002864 <led_on>
 800295e:	4638      	mov	r0, r7
 8002960:	f7ff ff96 	bl	8002890 <led_off>
 8002964:	4628      	mov	r0, r5
 8002966:	f7ff ff93 	bl	8002890 <led_off>
 800296a:	f242 7311 	movw	r3, #10001	; 0x2711
 800296e:	3b01      	subs	r3, #1
 8002970:	d001      	beq.n	8002976 <gpio_init+0xba>
 8002972:	bf00      	nop
 8002974:	e7fb      	b.n	800296e <gpio_init+0xb2>
 8002976:	2001      	movs	r0, #1
 8002978:	f7ff ff74 	bl	8002864 <led_on>
 800297c:	b002      	add	sp, #8
 800297e:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
 8002982:	bf00      	nop
 8002984:	48000400 	.word	0x48000400

08002988 <get_key>:
 8002988:	4b02      	ldr	r3, [pc, #8]	; (8002994 <get_key+0xc>)
 800298a:	8a18      	ldrh	r0, [r3, #16]
 800298c:	43c0      	mvns	r0, r0
 800298e:	f400 7000 	and.w	r0, r0, #512	; 0x200
 8002992:	4770      	bx	lr
 8002994:	48000400 	.word	0x48000400

08002998 <GPIO_Init>:
 8002998:	b5f0      	push	{r4, r5, r6, r7, lr}
 800299a:	bf00      	nop
 800299c:	bf00      	nop
 800299e:	bf00      	nop
 80029a0:	bf00      	nop
 80029a2:	2300      	movs	r3, #0
 80029a4:	680e      	ldr	r6, [r1, #0]
 80029a6:	461c      	mov	r4, r3
 80029a8:	2501      	movs	r5, #1
 80029aa:	40a5      	lsls	r5, r4
 80029ac:	ea05 0e06 	and.w	lr, r5, r6
 80029b0:	45ae      	cmp	lr, r5
 80029b2:	d12d      	bne.n	8002a10 <GPIO_Init+0x78>
 80029b4:	790f      	ldrb	r7, [r1, #4]
 80029b6:	1e7a      	subs	r2, r7, #1
 80029b8:	2a01      	cmp	r2, #1
 80029ba:	d817      	bhi.n	80029ec <GPIO_Init+0x54>
 80029bc:	bf00      	nop
 80029be:	2203      	movs	r2, #3
 80029c0:	6885      	ldr	r5, [r0, #8]
 80029c2:	409a      	lsls	r2, r3
 80029c4:	ea25 0202 	bic.w	r2, r5, r2
 80029c8:	6082      	str	r2, [r0, #8]
 80029ca:	794d      	ldrb	r5, [r1, #5]
 80029cc:	6882      	ldr	r2, [r0, #8]
 80029ce:	409d      	lsls	r5, r3
 80029d0:	4315      	orrs	r5, r2
 80029d2:	6085      	str	r5, [r0, #8]
 80029d4:	bf00      	nop
 80029d6:	8882      	ldrh	r2, [r0, #4]
 80029d8:	b292      	uxth	r2, r2
 80029da:	ea22 020e 	bic.w	r2, r2, lr
 80029de:	8082      	strh	r2, [r0, #4]
 80029e0:	798a      	ldrb	r2, [r1, #6]
 80029e2:	8885      	ldrh	r5, [r0, #4]
 80029e4:	40a2      	lsls	r2, r4
 80029e6:	432a      	orrs	r2, r5
 80029e8:	b292      	uxth	r2, r2
 80029ea:	8082      	strh	r2, [r0, #4]
 80029ec:	2203      	movs	r2, #3
 80029ee:	6805      	ldr	r5, [r0, #0]
 80029f0:	409a      	lsls	r2, r3
 80029f2:	43d2      	mvns	r2, r2
 80029f4:	4015      	ands	r5, r2
 80029f6:	6005      	str	r5, [r0, #0]
 80029f8:	6805      	ldr	r5, [r0, #0]
 80029fa:	409f      	lsls	r7, r3
 80029fc:	432f      	orrs	r7, r5
 80029fe:	6007      	str	r7, [r0, #0]
 8002a00:	68c7      	ldr	r7, [r0, #12]
 8002a02:	4017      	ands	r7, r2
 8002a04:	79ca      	ldrb	r2, [r1, #7]
 8002a06:	fa02 f503 	lsl.w	r5, r2, r3
 8002a0a:	ea47 0205 	orr.w	r2, r7, r5
 8002a0e:	60c2      	str	r2, [r0, #12]
 8002a10:	3401      	adds	r4, #1
 8002a12:	2c10      	cmp	r4, #16
 8002a14:	f103 0302 	add.w	r3, r3, #2
 8002a18:	d1c6      	bne.n	80029a8 <GPIO_Init+0x10>
 8002a1a:	bdf0      	pop	{r4, r5, r6, r7, pc}

08002a1c <GPIO_SetBits>:
 8002a1c:	bf00      	nop
 8002a1e:	bf00      	nop
 8002a20:	6181      	str	r1, [r0, #24]
 8002a22:	4770      	bx	lr

08002a24 <GPIO_ResetBits>:
 8002a24:	bf00      	nop
 8002a26:	bf00      	nop
 8002a28:	8501      	strh	r1, [r0, #40]	; 0x28
 8002a2a:	4770      	bx	lr

08002a2c <GPIO_PinAFConfig>:
 8002a2c:	b510      	push	{r4, lr}
 8002a2e:	bf00      	nop
 8002a30:	bf00      	nop
 8002a32:	bf00      	nop
 8002a34:	f001 0307 	and.w	r3, r1, #7
 8002a38:	08c9      	lsrs	r1, r1, #3
 8002a3a:	eb00 0081 	add.w	r0, r0, r1, lsl #2
 8002a3e:	009b      	lsls	r3, r3, #2
 8002a40:	6a04      	ldr	r4, [r0, #32]
 8002a42:	210f      	movs	r1, #15
 8002a44:	4099      	lsls	r1, r3
 8002a46:	ea24 0101 	bic.w	r1, r4, r1
 8002a4a:	6201      	str	r1, [r0, #32]
 8002a4c:	6a01      	ldr	r1, [r0, #32]
 8002a4e:	409a      	lsls	r2, r3
 8002a50:	430a      	orrs	r2, r1
 8002a52:	6202      	str	r2, [r0, #32]
 8002a54:	bd10      	pop	{r4, pc}

08002a56 <i2c_delay>:
 8002a56:	230b      	movs	r3, #11
 8002a58:	3b01      	subs	r3, #1
 8002a5a:	d001      	beq.n	8002a60 <i2c_delay+0xa>
 8002a5c:	bf00      	nop
 8002a5e:	e7fb      	b.n	8002a58 <i2c_delay+0x2>
 8002a60:	4770      	bx	lr
	...

08002a64 <SetLowSDA>:
 8002a64:	b537      	push	{r0, r1, r2, r4, r5, lr}
 8002a66:	4d0d      	ldr	r5, [pc, #52]	; (8002a9c <SetLowSDA+0x38>)
 8002a68:	2301      	movs	r3, #1
 8002a6a:	2203      	movs	r2, #3
 8002a6c:	2480      	movs	r4, #128	; 0x80
 8002a6e:	f88d 3004 	strb.w	r3, [sp, #4]
 8002a72:	f88d 3006 	strb.w	r3, [sp, #6]
 8002a76:	4628      	mov	r0, r5
 8002a78:	2300      	movs	r3, #0
 8002a7a:	4669      	mov	r1, sp
 8002a7c:	f88d 2005 	strb.w	r2, [sp, #5]
 8002a80:	f88d 3007 	strb.w	r3, [sp, #7]
 8002a84:	9400      	str	r4, [sp, #0]
 8002a86:	f7ff ff87 	bl	8002998 <GPIO_Init>
 8002a8a:	4628      	mov	r0, r5
 8002a8c:	4621      	mov	r1, r4
 8002a8e:	f7ff ffc9 	bl	8002a24 <GPIO_ResetBits>
 8002a92:	f7ff ffe0 	bl	8002a56 <i2c_delay>
 8002a96:	b003      	add	sp, #12
 8002a98:	bd30      	pop	{r4, r5, pc}
 8002a9a:	bf00      	nop
 8002a9c:	48000400 	.word	0x48000400

08002aa0 <SetHighSDA>:
 8002aa0:	b537      	push	{r0, r1, r2, r4, r5, lr}
 8002aa2:	4d0d      	ldr	r5, [pc, #52]	; (8002ad8 <SetHighSDA+0x38>)
 8002aa4:	2203      	movs	r2, #3
 8002aa6:	2300      	movs	r3, #0
 8002aa8:	2480      	movs	r4, #128	; 0x80
 8002aaa:	f88d 2005 	strb.w	r2, [sp, #5]
 8002aae:	4628      	mov	r0, r5
 8002ab0:	2201      	movs	r2, #1
 8002ab2:	4669      	mov	r1, sp
 8002ab4:	f88d 3004 	strb.w	r3, [sp, #4]
 8002ab8:	f88d 2006 	strb.w	r2, [sp, #6]
 8002abc:	f88d 3007 	strb.w	r3, [sp, #7]
 8002ac0:	9400      	str	r4, [sp, #0]
 8002ac2:	f7ff ff69 	bl	8002998 <GPIO_Init>
 8002ac6:	4628      	mov	r0, r5
 8002ac8:	4621      	mov	r1, r4
 8002aca:	f7ff ffa7 	bl	8002a1c <GPIO_SetBits>
 8002ace:	f7ff ffc2 	bl	8002a56 <i2c_delay>
 8002ad2:	b003      	add	sp, #12
 8002ad4:	bd30      	pop	{r4, r5, pc}
 8002ad6:	bf00      	nop
 8002ad8:	48000400 	.word	0x48000400

08002adc <SetLowSCL>:
 8002adc:	b508      	push	{r3, lr}
 8002ade:	4804      	ldr	r0, [pc, #16]	; (8002af0 <SetLowSCL+0x14>)
 8002ae0:	2140      	movs	r1, #64	; 0x40
 8002ae2:	f7ff ff9f 	bl	8002a24 <GPIO_ResetBits>
 8002ae6:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 8002aea:	f7ff bfb4 	b.w	8002a56 <i2c_delay>
 8002aee:	bf00      	nop
 8002af0:	48000400 	.word	0x48000400

08002af4 <SetHighSCL>:
 8002af4:	b508      	push	{r3, lr}
 8002af6:	4804      	ldr	r0, [pc, #16]	; (8002b08 <SetHighSCL+0x14>)
 8002af8:	2140      	movs	r1, #64	; 0x40
 8002afa:	f7ff ff8f 	bl	8002a1c <GPIO_SetBits>
 8002afe:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 8002b02:	f7ff bfa8 	b.w	8002a56 <i2c_delay>
 8002b06:	bf00      	nop
 8002b08:	48000400 	.word	0x48000400

08002b0c <i2c_0_init>:
 8002b0c:	b507      	push	{r0, r1, r2, lr}
 8002b0e:	f44f 2080 	mov.w	r0, #262144	; 0x40000
 8002b12:	2101      	movs	r1, #1
 8002b14:	f7ff fb32 	bl	800217c <RCC_AHBPeriphClockCmd>
 8002b18:	23c0      	movs	r3, #192	; 0xc0
 8002b1a:	9300      	str	r3, [sp, #0]
 8002b1c:	2301      	movs	r3, #1
 8002b1e:	2203      	movs	r2, #3
 8002b20:	480a      	ldr	r0, [pc, #40]	; (8002b4c <i2c_0_init+0x40>)
 8002b22:	f88d 3004 	strb.w	r3, [sp, #4]
 8002b26:	4669      	mov	r1, sp
 8002b28:	f88d 3006 	strb.w	r3, [sp, #6]
 8002b2c:	2300      	movs	r3, #0
 8002b2e:	f88d 2005 	strb.w	r2, [sp, #5]
 8002b32:	f88d 3007 	strb.w	r3, [sp, #7]
 8002b36:	f7ff ff2f 	bl	8002998 <GPIO_Init>
 8002b3a:	f7ff ffdb 	bl	8002af4 <SetHighSCL>
 8002b3e:	f7ff ff91 	bl	8002a64 <SetLowSDA>
 8002b42:	f7ff ffad 	bl	8002aa0 <SetHighSDA>
 8002b46:	b003      	add	sp, #12
 8002b48:	f85d fb04 	ldr.w	pc, [sp], #4
 8002b4c:	48000400 	.word	0x48000400

08002b50 <i2cStart>:
 8002b50:	b508      	push	{r3, lr}
 8002b52:	f7ff ffcf 	bl	8002af4 <SetHighSCL>
 8002b56:	f7ff ffa3 	bl	8002aa0 <SetHighSDA>
 8002b5a:	f7ff ffcb 	bl	8002af4 <SetHighSCL>
 8002b5e:	f7ff ff81 	bl	8002a64 <SetLowSDA>
 8002b62:	f7ff ffbb 	bl	8002adc <SetLowSCL>
 8002b66:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 8002b6a:	f7ff bf99 	b.w	8002aa0 <SetHighSDA>

08002b6e <i2cStop>:
 8002b6e:	b508      	push	{r3, lr}
 8002b70:	f7ff ffb4 	bl	8002adc <SetLowSCL>
 8002b74:	f7ff ff76 	bl	8002a64 <SetLowSDA>
 8002b78:	f7ff ffbc 	bl	8002af4 <SetHighSCL>
 8002b7c:	f7ff ff72 	bl	8002a64 <SetLowSDA>
 8002b80:	f7ff ffb8 	bl	8002af4 <SetHighSCL>
 8002b84:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 8002b88:	f7ff bf8a 	b.w	8002aa0 <SetHighSDA>

08002b8c <i2cWrite>:
 8002b8c:	b538      	push	{r3, r4, r5, lr}
 8002b8e:	4605      	mov	r5, r0
 8002b90:	2408      	movs	r4, #8
 8002b92:	f7ff ffa3 	bl	8002adc <SetLowSCL>
 8002b96:	062b      	lsls	r3, r5, #24
 8002b98:	d502      	bpl.n	8002ba0 <i2cWrite+0x14>
 8002b9a:	f7ff ff81 	bl	8002aa0 <SetHighSDA>
 8002b9e:	e001      	b.n	8002ba4 <i2cWrite+0x18>
 8002ba0:	f7ff ff60 	bl	8002a64 <SetLowSDA>
 8002ba4:	3c01      	subs	r4, #1
 8002ba6:	f7ff ffa5 	bl	8002af4 <SetHighSCL>
 8002baa:	006d      	lsls	r5, r5, #1
 8002bac:	f014 04ff 	ands.w	r4, r4, #255	; 0xff
 8002bb0:	b2ed      	uxtb	r5, r5
 8002bb2:	d1ee      	bne.n	8002b92 <i2cWrite+0x6>
 8002bb4:	f7ff ff92 	bl	8002adc <SetLowSCL>
 8002bb8:	f7ff ff72 	bl	8002aa0 <SetHighSDA>
 8002bbc:	f7ff ff9a 	bl	8002af4 <SetHighSCL>
 8002bc0:	4b05      	ldr	r3, [pc, #20]	; (8002bd8 <i2cWrite+0x4c>)
 8002bc2:	8a1c      	ldrh	r4, [r3, #16]
 8002bc4:	b2a4      	uxth	r4, r4
 8002bc6:	f7ff ff89 	bl	8002adc <SetLowSCL>
 8002bca:	f7ff ff44 	bl	8002a56 <i2c_delay>
 8002bce:	f084 0080 	eor.w	r0, r4, #128	; 0x80
 8002bd2:	f3c0 10c0 	ubfx	r0, r0, #7, #1
 8002bd6:	bd38      	pop	{r3, r4, r5, pc}
 8002bd8:	48000400 	.word	0x48000400

08002bdc <i2cRead>:
 8002bdc:	b570      	push	{r4, r5, r6, lr}
 8002bde:	4606      	mov	r6, r0
 8002be0:	f7ff ff7c 	bl	8002adc <SetLowSCL>
 8002be4:	f7ff ff5c 	bl	8002aa0 <SetHighSDA>
 8002be8:	2508      	movs	r5, #8
 8002bea:	2400      	movs	r4, #0
 8002bec:	f7ff ff82 	bl	8002af4 <SetHighSCL>
 8002bf0:	4b0d      	ldr	r3, [pc, #52]	; (8002c28 <i2cRead+0x4c>)
 8002bf2:	8a1b      	ldrh	r3, [r3, #16]
 8002bf4:	0064      	lsls	r4, r4, #1
 8002bf6:	061b      	lsls	r3, r3, #24
 8002bf8:	b2e4      	uxtb	r4, r4
 8002bfa:	bf48      	it	mi
 8002bfc:	3401      	addmi	r4, #1
 8002bfe:	f105 35ff 	add.w	r5, r5, #4294967295	; 0xffffffff
 8002c02:	bf48      	it	mi
 8002c04:	b2e4      	uxtbmi	r4, r4
 8002c06:	f7ff ff69 	bl	8002adc <SetLowSCL>
 8002c0a:	f015 05ff 	ands.w	r5, r5, #255	; 0xff
 8002c0e:	d1ed      	bne.n	8002bec <i2cRead+0x10>
 8002c10:	b10e      	cbz	r6, 8002c16 <i2cRead+0x3a>
 8002c12:	f7ff ff27 	bl	8002a64 <SetLowSDA>
 8002c16:	f7ff ff6d 	bl	8002af4 <SetHighSCL>
 8002c1a:	f7ff ff5f 	bl	8002adc <SetLowSCL>
 8002c1e:	f7ff ff1a 	bl	8002a56 <i2c_delay>
 8002c22:	4620      	mov	r0, r4
 8002c24:	bd70      	pop	{r4, r5, r6, pc}
 8002c26:	bf00      	nop
 8002c28:	48000400 	.word	0x48000400

08002c2c <i2c_write_reg>:
 8002c2c:	b570      	push	{r4, r5, r6, lr}
 8002c2e:	4606      	mov	r6, r0
 8002c30:	460d      	mov	r5, r1
 8002c32:	4614      	mov	r4, r2
 8002c34:	f7ff ff8c 	bl	8002b50 <i2cStart>
 8002c38:	4630      	mov	r0, r6
 8002c3a:	f7ff ffa7 	bl	8002b8c <i2cWrite>
 8002c3e:	4628      	mov	r0, r5
 8002c40:	f7ff ffa4 	bl	8002b8c <i2cWrite>
 8002c44:	4620      	mov	r0, r4
 8002c46:	f7ff ffa1 	bl	8002b8c <i2cWrite>
 8002c4a:	e8bd 4070 	ldmia.w	sp!, {r4, r5, r6, lr}
 8002c4e:	f7ff bf8e 	b.w	8002b6e <i2cStop>

08002c52 <i2c_read_reg>:
 8002c52:	b538      	push	{r3, r4, r5, lr}
 8002c54:	4604      	mov	r4, r0
 8002c56:	460d      	mov	r5, r1
 8002c58:	f7ff ff7a 	bl	8002b50 <i2cStart>
 8002c5c:	4620      	mov	r0, r4
 8002c5e:	f7ff ff95 	bl	8002b8c <i2cWrite>
 8002c62:	4628      	mov	r0, r5
 8002c64:	f7ff ff92 	bl	8002b8c <i2cWrite>
 8002c68:	f7ff ff72 	bl	8002b50 <i2cStart>
 8002c6c:	f044 0001 	orr.w	r0, r4, #1
 8002c70:	f7ff ff8c 	bl	8002b8c <i2cWrite>
 8002c74:	2000      	movs	r0, #0
 8002c76:	f7ff ffb1 	bl	8002bdc <i2cRead>
 8002c7a:	4604      	mov	r4, r0
 8002c7c:	f7ff ff77 	bl	8002b6e <i2cStop>
 8002c80:	4620      	mov	r0, r4
 8002c82:	bd38      	pop	{r3, r4, r5, pc}

08002c84 <_init>:
 8002c84:	e1a0c00d 	mov	ip, sp
 8002c88:	e92ddff8 	push	{r3, r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
 8002c8c:	e24cb004 	sub	fp, ip, #4
 8002c90:	e24bd028 	sub	sp, fp, #40	; 0x28
 8002c94:	e89d6ff0 	ldm	sp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, lr}
 8002c98:	e12fff1e 	bx	lr

08002c9c <_fini>:
 8002c9c:	e1a0c00d 	mov	ip, sp
 8002ca0:	e92ddff8 	push	{r3, r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
 8002ca4:	e24cb004 	sub	fp, ip, #4
 8002ca8:	e24bd028 	sub	sp, fp, #40	; 0x28
 8002cac:	e89d6ff0 	ldm	sp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, lr}
 8002cb0:	e12fff1e 	bx	lr
 8002cb4:	00000020 	.word	0x00000020
 8002cb8:	00000040 	.word	0x00000040
 8002cbc:	00000060 	.word	0x00000060
 8002cc0:	00000080 	.word	0x00000080
 8002cc4:	432b5441 	.word	0x432b5441
 8002cc8:	554d5049 	.word	0x554d5049
 8002ccc:	0d313d58 	.word	0x0d313d58
 8002cd0:	5441000a 	.word	0x5441000a
 8002cd4:	5049432b 	.word	0x5049432b
 8002cd8:	3d58554d 	.word	0x3d58554d
 8002cdc:	000a0d30 	.word	0x000a0d30
 8002ce0:	432b5441 	.word	0x432b5441
 8002ce4:	444f4d57 	.word	0x444f4d57
 8002ce8:	0d313d45 	.word	0x0d313d45
 8002cec:	5441000a 	.word	0x5441000a
 8002cf0:	4a57432b 	.word	0x4a57432b
 8002cf4:	223d5041 	.word	0x223d5041
 8002cf8:	72656100 	.word	0x72656100
 8002cfc:	61007369 	.word	0x61007369
 8002d00:	65646362 	.word	0x65646362
 8002d04:	00686766 	.word	0x00686766
 8002d08:	000a0d22 	.word	0x000a0d22
 8002d0c:	432b5441 	.word	0x432b5441
 8002d10:	45535049 	.word	0x45535049
 8002d14:	52455652 	.word	0x52455652
 8002d18:	382c313d 	.word	0x382c313d
 8002d1c:	000a0d30 	.word	0x000a0d30
 8002d20:	432b5441 	.word	0x432b5441
 8002d24:	4c435049 	.word	0x4c435049
 8002d28:	0d45534f 	.word	0x0d45534f
 8002d2c:	5441000a 	.word	0x5441000a
 8002d30:	5049432b 	.word	0x5049432b
 8002d34:	52415453 	.word	0x52415453
 8002d38:	54223d54 	.word	0x54223d54
 8002d3c:	2c225043 	.word	0x2c225043
 8002d40:	2c220022 	.word	0x2c220022
 8002d44:	4e4f4300 	.word	0x4e4f4300
 8002d48:	5443454e 	.word	0x5443454e
 8002d4c:	2b544100 	.word	0x2b544100
 8002d50:	53504943 	.word	0x53504943
 8002d54:	3d444e45 	.word	0x3d444e45
 8002d58:	53003e00 	.word	0x53003e00
 8002d5c:	20444e45 	.word	0x20444e45
 8002d60:	2b004b4f 	.word	0x2b004b4f
 8002d64:	2c445049 	.word	0x2c445049
 8002d68:	2b003a31 	.word	0x2b003a31
 8002d6c:	2c445049 	.word	0x2c445049
 8002d70:	32393100 	.word	0x32393100
 8002d74:	3836312e 	.word	0x3836312e
 8002d78:	2e33342e 	.word	0x2e33342e
 8002d7c:	00373531 	.word	0x00373531
 8002d80:	69647473 	.word	0x69647473
 8002d84:	6e69206f 	.word	0x6e69206f
 8002d88:	64207469 	.word	0x64207469
 8002d8c:	0a656e6f 	.word	0x0a656e6f
 8002d90:	00          	.byte	0x00
 8002d91:	65          	.byte	0x65
 8002d92:	7272      	.short	0x7272
 8002d94:	6320726f 	.word	0x6320726f
 8002d98:	2065646f 	.word	0x2065646f
 8002d9c:	253a7525 	.word	0x253a7525
 8002da0:	0a75      	.short	0x0a75
 8002da2:	00          	.byte	0x00
 8002da3:	4c          	.byte	0x4c
 8002da4:	44394d53 	.word	0x44394d53
 8002da8:	3a203053 	.word	0x3a203053
 8002dac:	69250020 	.word	0x69250020
 8002db0:	20692520 	.word	0x20692520
 8002db4:	2c206925 	.word	0x2c206925
 8002db8:	69250020 	.word	0x69250020
 8002dbc:	20692520 	.word	0x20692520
 8002dc0:	0a006925 	.word	0x0a006925
 8002dc4:	20424752 	.word	0x20424752
 8002dc8:	66727573 	.word	0x66727573
 8002dcc:	20656361 	.word	0x20656361
 8002dd0:	0a00203a 	.word	0x0a00203a
 8002dd4:	00203a52 	.word	0x00203a52
 8002dd8:	00206925 	.word	0x00206925
 8002ddc:	203a470a 	.word	0x203a470a
 8002de0:	3a420a00 	.word	0x3a420a00
 8002de4:	0a0a0020 	.word	0x0a0a0020
 8002de8:	20692500 	.word	0x20692500
 8002dec:	25206925 	.word	0x25206925
 8002df0:	0d000a69 	.word	0x0d000a69
 8002df4:	4332490a 	.word	0x4332490a
 8002df8:	4344415f 	.word	0x4344415f
 8002dfc:	0a0d003a 	.word	0x0a0d003a
 8002e00:	5f434441 	.word	0x5f434441
 8002e04:	3a544142 	.word	0x3a544142
 8002e08:	00          	.byte	0x00
 8002e09:	0a          	.byte	0x0a
 8002e0a:	6577      	.short	0x6577
 8002e0c:	6d6f636c 	.word	0x6d6f636c
 8002e10:	6f742065 	.word	0x6f742065
 8002e14:	7a755320 	.word	0x7a755320
 8002e18:	4f616875 	.word	0x4f616875
 8002e1c:	5f5e2053 	.word	0x5f5e2053
 8002e20:	2e32205e 	.word	0x2e32205e
 8002e24:	0a362e30 	.word	0x0a362e30
 8002e28:	4c495542 	.word	0x4c495542
 8002e2c:	614d2044 	.word	0x614d2044
 8002e30:	31332079 	.word	0x31332079
 8002e34:	31303220 	.word	0x31303220
 8002e38:	31312038 	.word	0x31312038
 8002e3c:	3a39353a 	.word	0x3a39353a
 8002e40:	000a3233 	.word	0x000a3233

08002e44 <CSWTCH.2>:
 8002e44:	50000000 50000000 50000000 50000100     ...P...P...P...P
 8002e54:	50000100 50000100 50000100 50000400     ...P...P...P...P
 8002e64:	50000000                                ...P

08002e68 <CSWTCH.3>:
 8002e68:	01040302 0c040302 00000012              ............

08002e74 <__EH_FRAME_BEGIN__>:
 8002e74:	00000000                                ....
